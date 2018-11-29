//
//  GameScene.swift
//  DisappearingDiscs
//
//  Created by 10.12 on 2018/11/29.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

var scoreNumber = 0

class GameScene: SKScene {
    
    let scoreLabel = SKLabelNode(fontNamed: "Pusab")
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)

    let playGameOverSoundEffect = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)

    
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
        
        scoreNumber = 0
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0 // background picture at layer 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Disc2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2  // disc picture at layer 2
        disc.name = "discObject"
        self.addChild(disc)
        
        // add score label to scene
        scoreLabel.fontSize = 250
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.zPosition = 1  // score Label at layer 1
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.85)
        self.addChild(scoreLabel)
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
        
        // shrink the disc when it's added to the screen
        disc.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 3.0),
            playGameOverSoundEffect,
            SKAction.run(runGameOver)
            ]))
    
        
    }
    
    func runGameOver() {
        // move to game over scene
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransiton = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransiton)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "discObject" {
                tappedNode.name = "" // to avoid collison
                tappedNode.removeAllActions() // stop shrink and game over discs fade: 0.1 game over transition = 0.2
                // 1.delete the current disc
                   // tappedNode.removeFromParent() have better way to disapper
                tappedNode.run(SKAction.sequence([
                    SKAction.fadeIn(withDuration: 0.1),
                    SKAction.removeFromParent()
                    ]))
                   // add play correct sound effect when tap a disc
                self.run(playCorrectSoundEffect)
                
                // 2.create a new disc
                spawnNewDisc()
                // 3.Add 1 to score
                scoreNumber += 1
                scoreLabel.text = "\(scoreNumber)"
                // 4. Reach a certain score, add more discs on screen
                if scoreNumber == 10 || scoreNumber == 50 || scoreNumber == 125 || scoreNumber == 200 || scoreNumber == 300 || scoreNumber == 500 {
                    spawnNewDisc()
                }
                
            }
        }
    }
}











