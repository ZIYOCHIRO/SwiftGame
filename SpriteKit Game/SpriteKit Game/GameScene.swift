//
//  Game.swift
//  SpriteKit Game
//
//  Created by 10.12 on 2018/12/10.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    var points = 0
    enum Collidertype: UInt32 {
        case player = 1
        case target = 2
    }
    var target: SKSpriteNode!
    var value: Float = 0.0
    
    override func didMove(to view: SKView) {
        //
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
}


