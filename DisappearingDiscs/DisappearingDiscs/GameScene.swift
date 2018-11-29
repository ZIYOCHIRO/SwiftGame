//
//  GameScene.swift
//  DisappearingDiscs
//
//  Created by 10.12 on 2018/11/29.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Create game area for universal devices
    let gameArea: CGRect
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: size.height)
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Disc2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
    }
    
    func spawnNewDisc() {
        // Create a random from 1 to 4
        var randomImageNumber = arc4random()%4 // (0,1,2,3)
        randomImageNumber += 1
        
        // get random image
        let disc = SKSpriteNode(imageNamed: "Disc\(randomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        
        // Create random position in game area and make the disc full
        let randomX = random(min: gameArea.minX + disc.size.width / 2, max: gameArea.maxX - disc.size.width / 2)
        let randomY = random(min: gameArea.minY + disc.size.height / 2, max: gameArea.maxY - disc.size.height / 2 )
        
        disc.position = CGPoint(x: randomX, y: randomY)
        self.addChild(disc)
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "discObject" {
                // 1.delete the current disc
                tappedNode.removeFromParent()
                // 2.create a new disc
                spawnNewDisc()
            }
        }
    }
}











