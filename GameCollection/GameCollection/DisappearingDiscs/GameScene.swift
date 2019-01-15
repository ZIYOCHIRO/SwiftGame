//
//  GameScene.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/14.
//  Copyright © 2019 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var scoreNumber = 0
    let scoreLabel = SKLabelNode(fontNamed: theme.disappearingDicsFontName)
    let playGameOverSoundEffect = SKAction.playSoundFileNamed(constants.discGameOverSoundEffect, waitForCompletion: false)
    let playCorrectSoundEffect = SKAction.playSoundFileNamed(constants.discCorrectSoundEffect, waitForCompletion: false)

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
    
    // called immediately after a scene is presently by a view
    override func didMove(to view: SKView) {
        
        scoreNumber = 0
        
        // set background
        scene?.backgroundColor = theme.backgroundColor!
        
        // set disc
        let disc = SKSpriteNode(imageNamed: "Disc-2")
        disc.setScale(2)
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = constants.discIdName
        self.addChild(disc)
        
        // set scoreLabel
        scoreLabel.fontSize = 250
        scoreLabel.text = "0"
        scoreLabel.fontColor = theme.tintColor
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.9)
        self.addChild(scoreLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionOfTouch = touch.location(in: self)
            let tappedNode = atPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == constants.discIdName {
                tappedNode.name = ""
                tappedNode.removeAllActions()
                // 1. delete current disc
                tappedNode.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.1),
                                                  SKAction.removeFromParent()]))
                self.run(playCorrectSoundEffect)
                // 2. create a new disc
                spawnNewDisc()
                // 3. add 1 to score
                self.scoreNumber += 1
                scoreLabel.text = "\(scoreNumber)"
                // 4. reach a certain score, level up
                if scoreNumber == 10 || scoreNumber == 50 || scoreNumber == 125 || scoreNumber == 200 || scoreNumber == 300 || scoreNumber == 500 {
                    spawnNewDisc()
                }
                
            }
        }
    }
    
    func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        let random = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        return random * (max - min) + min
    }
    
    
    func spawnNewDisc() {
        // create a random number froom 1 to 6
        var randomImageNumber = arc4random()%6
        randomImageNumber += 1
        
        // get random image
        let disc = SKSpriteNode(imageNamed: "Disc-\(randomImageNumber)")
        disc.setScale(2)
        disc.zPosition = 2
        disc.name = constants.discIdName
        
        // create random position in game area
        let randomX = randomCGFloat(min: gameArea.minX + disc.size.width / 2, max: gameArea.maxX - disc.size.width / 2)
        let randomY = randomCGFloat(min: gameArea.minY + disc.size.height / 2, max: gameArea.maxY - disc.size.height / 2 )
        disc.position = CGPoint(x: randomX, y: randomY)
        
        self.addChild(disc)
        
        // shrink the disc immediately when it's added to the scene
        disc.run(SKAction.sequence([SKAction.scale(to: 0, duration: 3.0),
                                    playGameOverSoundEffect,
                                    SKAction.run(runGameOver)]))
    }
    
    func runGameOver() {
        // move to gameOver scene
        let sceneToMoveTo = MainMenuScene(size: self.size)
        sceneToMoveTo.scoreNumber = self.scoreNumber
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
    }
}
