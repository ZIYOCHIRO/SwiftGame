//
//  MainMenuScene.swift
//  DisappearingDiscs
//
//  Created by 10.12 on 2018/11/29.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    let playClickSoundEffect = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        
        // set the background
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        
        // set the Label_1
        let gameTitileLabel1 = SKLabelNode(fontNamed: "Pusab")
        gameTitileLabel1.text = "Disappearing"
        gameTitileLabel1.fontSize = 90
        gameTitileLabel1.fontColor = SKColor.white
        gameTitileLabel1.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        gameTitileLabel1.zPosition = 1
        self.addChild(gameTitileLabel1)
        
        // set the label_2
        let gameTitileLabel2 = SKLabelNode(fontNamed: "Pusab")
        gameTitileLabel2.text = "Discs"
        gameTitileLabel2.fontSize = 250
        gameTitileLabel2.fontColor = SKColor.white
        gameTitileLabel2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.6)
        gameTitileLabel2.zPosition = 1
        self.addChild(gameTitileLabel2)
        
        // set the label_3
        let gameByLabel = SKLabelNode(fontNamed: "Pusab")
        gameByLabel.text = "Isla Riley Apps presents"
        gameByLabel.fontSize = 50
        gameByLabel.fontColor = SKColor.white
        gameByLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.95)
        gameByLabel.zPosition = 1
        self.addChild(gameByLabel)
        
        // set the label_4
        let howToPlayLable = SKLabelNode(fontNamed: "Pusab")
        howToPlayLable.text = "Tap the Discs Before They Vanish"
        howToPlayLable.fontSize = 40
        howToPlayLable.fontColor = SKColor.white
        howToPlayLable.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.08)
        howToPlayLable.zPosition = 1
        self.addChild(howToPlayLable)
        
        // set the label_5
        let creditsLabel = SKLabelNode(fontNamed: "Pusab")
        creditsLabel.text = "Full Credits In the Video Description"
        creditsLabel.fontSize = 40
        creditsLabel.fontColor = SKColor.white
        creditsLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.04)
        creditsLabel.zPosition = 1
        self.addChild(creditsLabel)
        
        // set the label_6
        let startLabel = SKLabelNode(fontNamed: "Pusab")
        startLabel.text = "Play"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.white
        startLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.35)
        startLabel.name = "startButton"
        startLabel.zPosition = 1
        self.addChild(startLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let tappedNode = atPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "startButton" {
                
                self.run(playClickSoundEffect)
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
        }
    }
    
}











