//
//  GameOverScene.swift
//  Space Invaders
//
//  Created by 10.12 on 2018/12/3.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let restartLabel = SKLabelNode(fontNamed: "theBoldFont")
    
    override func didMove(to view: SKView) {
        
        // set background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // set gameOverLabel
        let gameOverLabel = SKLabelNode(fontNamed: "theBoldFont")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 180
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        // set scoreLabel
        let scoreLabel = SKLabelNode(fontNamed: "theBoldFont")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        // set highScoreLabel + consistence using userdefaluts
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "theBoldFont")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
    
        
        // set restart Label
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = UIColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let pointOfTouch = touch.location(in: self)
            if restartLabel.contains(pointOfTouch) {
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}







