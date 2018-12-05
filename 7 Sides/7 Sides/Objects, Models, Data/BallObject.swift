//
//  BallObject.swift
//  7 Sides
//
//  Created by 10.12 on 2018/12/5.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    let type: colorType
    var isActive: Bool = true
    
    init() {
        // add random color ball
        let randomTypeIndex = Int(arc4random()%7) // (0...6)
        self.type = colorWheelOrder[randomTypeIndex]
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        super.init(texture: ballTexture, color: UIColor.clear, size: ballTexture.size())
        // add physical body as circle
        self.physicsBody = SKPhysicsBody(circleOfRadius: 55)
        self.physicsBody!.affectedByGravity = false
        // collision: two physics body will bump each other out of the way
        // contact: we can run some code when two physics bodies hit
        self.physicsBody!.categoryBitMask = PhysicsCategories.Ball
        self.physicsBody!.collisionBitMask = PhysicsCategories.None  // no collision
        self.physicsBody!.contactTestBitMask = PhysicsCategories.Side  // contact with Side
        // scale in
        self.setScale(0)
        let scaleIn = SKAction.scale(to: 1, duration: 0.2)
        self.run(scaleIn)
        // move to random side
        let randomSideIndex = Int(arc4random()%7)
        let sideToMoveTo = sidePositionArray[randomSideIndex]
        let moveToSide = SKAction.move(to: sideToMoveTo, duration: 2)
        
        let ballSpawnSequence = SKAction.sequence([scaleIn, moveToSide])
        self.run(ballSpawnSequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delete() {
        
        self.isActive = false
        self.removeAllActions()
        let scaleDown = SKAction.scale(by: 0, duration: 0.2)
        let deleteBall = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteBall])
        self.run(deleteSequence)
    }
}





