//
//  MainMenuScene.swift
//  Space Invaders
//
//  Created by 10.12 on 2018/12/4.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // Set background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // Set game by XXXX label
        let gameByLabel = SKLabelNode(fontNamed: "theBoldFont")
        gameByLabel.text = "Isla Rui's"
        gameByLabel.fontSize = 50
        gameByLabel.fontColor = UIColor.white
        gameByLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.78)
        gameByLabel.zPosition = 1
        self.addChild(gameByLabel)
        
        // Set game name_1 Label
        let gameName1 = SKLabelNode(fontNamed: "theBoldFont")
        gameName1.text = "Space"
        gameName1.fontSize = 200
        gameName1.fontColor = UIColor.white
        gameName1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        // Set game name_2 Label
        let gameName2 = SKLabelNode(fontNamed: "theBoldFont")
        gameName2.text = "Invaders"
        gameName2.fontSize = 200
        gameName2.fontColor = UIColor.white
        gameName2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.625)
        gameName2.zPosition = 1
        self.addChild(gameName2)
        
        // Set start game Label
        let startGame = SKLabelNode(fontNamed: "theBoldFont")
        startGame.text = "Start Game"
        startGame.fontSize = 125
        startGame.fontColor = UIColor.white
        startGame.position = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        startGame.zPosition = 1
        startGame.name = "StartButton"
        self.addChild(startGame)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            
            if nodeITapped.name == "StartButton" {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
