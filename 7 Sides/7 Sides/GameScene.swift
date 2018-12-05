//
//  GameScene.swift
//  7 Sides
//
//  Created by 10.12 on 2018/12/4.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var colorWheelBase = SKShapeNode()
    
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360/7), duration: 0.2)
    
    override func didMove(to view: SKView) {
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
        
    }
    
    func preColorwheel() {
        
        for i in 0...6 {
            let side = Side(type: colorWheelOrder[i])
            let basePosition = CGPoint(x: self.size.width/2, y: self.size.height*0.28 )
            side.position = convert(basePosition, to: colorWheelBase)
            side.setScale(0.9)
            side.zRotation = -colorWheelBase.zRotation
            side.zPosition = 1
            colorWheelBase.addChild(side)
            colorWheelBase.zRotation += convertDegreesToRadians(degrees: 360/7)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        colorWheelBase.run(spinColorWheel)
    }

}





