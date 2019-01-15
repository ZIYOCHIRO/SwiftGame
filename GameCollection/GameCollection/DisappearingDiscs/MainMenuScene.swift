//
//  MainMenuScene.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/15.
//  Copyright © 2019 Rui. All rights reserved.
//

import SpriteKit

class MainMenuScene:SKScene {
    
    var gamedelegate: DiscGameDelegate?

    var scoreNumber = 0
    let playClickSoundEffect = SKAction.playSoundFileNamed(constants.discClickSoundEffect, waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        
        
        // set the background
        scene?.backgroundColor = theme.tintColor!
        // set the score label
        let scoreLabel = SKLabelNode(fontNamed: theme.disappearingDicsFontName)
        scoreLabel.text = "Score: \(scoreNumber)"
        scoreLabel.fontSize = 100
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.6)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
       
        
        // set the highest score label
        let defaults = UserDefaults()
        var highestScoreNumber = defaults.integer(forKey: constants.discHighestScoreKey)
        if scoreNumber > highestScoreNumber {
            highestScoreNumber = scoreNumber
            defaults.set(highestScoreNumber, forKey: constants.discHighestScoreKey)
        }
        let highestScorelabel = SKLabelNode(fontNamed: theme.disappearingDicsFontName)
        highestScorelabel.text = "Highest Score: \(highestScoreNumber)"
        highestScorelabel.fontSize = 70
        highestScorelabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.5)
        highestScorelabel.zPosition = 1
        self.addChild(highestScorelabel)

        // set the start play label
        let startLabel = SKLabelNode(fontNamed: theme.disappearingDicsFontName)
        startLabel.text = "Start Play"
        startLabel.fontSize = 150
        startLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.4)
        startLabel.zPosition = 1
        startLabel.name = constants.discStartLabelId
        self.addChild(startLabel)
        
        // set the exit label
        let exitLabel = SKLabelNode(fontNamed: theme.disappearingDicsFontName)
        exitLabel.text = "Exit"
        exitLabel.fontSize = 70
        exitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        exitLabel.zPosition = 1
        exitLabel.name = constants.discExitLabelId
        self.addChild(exitLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == constants.discStartLabelId {
                
                self.run(playClickSoundEffect)
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == constants.discExitLabelId {
                self.run(playClickSoundEffect)
                gamedelegate?.exitGame()
            
            }
        }
    }
    
}

