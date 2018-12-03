//
//  GameScene.swift
//  Space Invaders
//
//  Created by 10.12 on 2018/11/30.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    let bulletSound = SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false)
    
    // This function will run as soon as the scene loads up
    override func didMove(to view: SKView) {
        // Create background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0 // in which layer
        self.addChild(background)
        // Create a player
        
        player.setScale(1) // want the image(player) to be bigger, increase the number
        player.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        player.zPosition = 2
        self.addChild(player)
        
    }

    
    
    func fireBullet() {
        
        // spawn a bullet
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        self.addChild(bullet)
        
        // move and been delete
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        // the actions above should happen in order
        let bulletSequence = SKAction.sequence([bulletSound,moveBullet,deleteBullet])
        bullet.run(bulletSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // run whenever you touch the screen
        fireBullet()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // where we touches the screen
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            // how big the gap is
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            player.position.x += amountDragged
        }
    }
}






