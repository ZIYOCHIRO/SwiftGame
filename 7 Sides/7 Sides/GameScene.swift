//
//  GameScene.swift
//  7 Sides
//
//  Created by 10.12 on 2018/12/4.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var colorWheelBase = SKShapeNode()
    
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360/7), duration: 0.2)
    
    var currentGameState = gameState.beforeGame
    
    let tapToStartLabel = SKLabelNode(fontNamed: "CaviarDreams")
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self

        // set the background
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1  //behind all object
        self.addChild(background)
        
        colorWheelBase = SKShapeNode(rectOf: CGSize(width: self.size.width*0.8, height: self.size.width*0.8))
        colorWheelBase.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        colorWheelBase.fillColor = SKColor.clear
        colorWheelBase.strokeColor = SKColor.clear
        colorWheelBase.zPosition = 0
        self.addChild(colorWheelBase)
        
        preColorwheel()
        
        tapToStartLabel.text = "Tap to Start"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = UIColor.darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(tapToStartLabel)
        
        
    }
    
    func preColorwheel() {
        
        for i in 0...6 {
            let side = Side(type: colorWheelOrder[i])
            let basePosition = CGPoint(x: self.size.width/2, y: self.size.height*0.3 )
            side.position = convert(basePosition, to: colorWheelBase)
            side.zRotation = -colorWheelBase.zRotation
            side.setScale(0.8)
            colorWheelBase.addChild(side)
            colorWheelBase.zRotation += convertDegreesToRadians(degrees: 360/7)
        }
        
        for side in colorWheelBase.children{
            let sidePosition = side.position
            let positionInScene = convert(sidePosition, from: colorWheelBase)
            sidePositionArray.append(positionInScene)
            
        }
        
        
    }
    
    func spawnBall() {
        
        let ball = Ball()
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(ball)
    }
    
    func startGame() {
        
        spawnBall()
        currentGameState = .inGame
        // delete the tap to start label
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
    }
    
    // built in function
    func didBegin(_ contact: SKPhysicsContact) {
        
        // delete the former ball
        let ball: Ball
        let side: Side
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.Ball {
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
        } else {
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        
        if ball.isActive == true {
            ball.delete()
            
            // when the last ball arrives the side, a new ball should appear
            spawnBall()
        }
        
        checkMatch(ball: ball, side: side)
    }
    
    func checkMatch(ball: Ball, side: Side) {
        
        if ball.type == side.type {
            // correct
            print("correct")
        } else {
            // incorrect
            print("No!!!!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == gameState.beforeGame {
            // start the game
            startGame()
            
        }
        else if currentGameState == gameState.inGame {
            // spin the color wheel
            colorWheelBase.run(spinColorWheel)
        }
        
        
    }

}





