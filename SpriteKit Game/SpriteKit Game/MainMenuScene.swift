//
//  GameScene.swift
//  SpriteKit Game
//
//  Created by 10.12 on 2018/12/10.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Main menu
        self.backgroundColor = UIColor.darkGray
        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Game with SpriteKie"
        myLabel.fontSize = 45
        myLabel.fontColor = UIColor.white
        myLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        myLabel.zPosition = 1
        self.addChild(myLabel)
        
        let myLabel2 = SKLabelNode(fontNamed: "Chalkduster")
        myLabel2.text = "Touch to start"
        myLabel2.fontSize = 40
        myLabel2.fontColor = UIColor.white
        myLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        myLabel2.zPosition = 1
        self.addChild(myLabel2)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touch anywhere then change scene to game scene
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
 
}




