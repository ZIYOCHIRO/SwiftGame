
//
//  GameOverScene.swift
//  DisappearingDiscs
//
//  Created by 10.12 on 2018/11/29.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let playClickSoundEffect = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    override func didMove(to view: SKView) {
        
        // Set background
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        
        // set game over label
        let gameOverLabel = SKLabelNode(fontNamed: "Pusab")
        gameOverLabel.text = " Game Over"
        gameOverLabel.fontSize = 140
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        // set final score label
        let finalScoreLabel = SKLabelNode(fontNamed: "Pusab")
        finalScoreLabel.text = "Score: \(scoreNumber)"
        finalScoreLabel.fontSize = 70
        finalScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.6)
        finalScoreLabel.fontColor = SKColor.white
        finalScoreLabel.zPosition = 1
        self.addChild(finalScoreLabel)
        
        // SAVE DATA using UserDefaults
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if scoreNumber > highScoreNumber {
            highScoreNumber = scoreNumber
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        // set highest score label
        let highScoreLabel = SKLabelNode(fontNamed: "Pusab")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 70
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.5)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        // set restart label
        let restartLabel = SKLabelNode(fontNamed: "Pusab")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 75
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        restartLabel.zPosition = 1
        restartLabel.name = "restartButton"  // use as a identifier
        self.addChild(restartLabel)
        
        // set exit label
        let exitLabel = SKLabelNode(fontNamed: "Pusab")
        exitLabel.text = "Exit"
        exitLabel.fontSize = 75
        exitLabel.fontColor = SKColor.white
        exitLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
        exitLabel.zPosition = 1
        exitLabel.name = "exitButton"  // use as a identifier
        self.addChild(exitLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            // touches the restart button, move to the game scene
            if tappedNodeName == "restartButton" {
                
                self.run(playClickSoundEffect)
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
            // touches the exit button, move to the main menu
            if tappedNodeName == "exitButton" {
                
                self.run(playClickSoundEffect)
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
        }
    }
}
