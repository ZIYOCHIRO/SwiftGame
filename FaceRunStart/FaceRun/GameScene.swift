//
//  GameScene.swift
//  FaceRun
//
//  Created by Brian Advent on 21.06.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var playerNode:Player?
    var moving:Bool = false
    
    var generator:UIImpactFeedbackGenerator!
    
    override func didMove(to view: SKView) {
        playerNode = self.childNode(withName: "player") as? Player
       
        generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        
    }
    
    
    func updatePlayer (state:PlayerState) {
      

    }
    
    func movePlayer (state:PlayerState) {
      
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
       
    }
}
