//
//  GameViewController.swift
//  SKEmitterTutorial
//
//  Created by Sean Allen on 11/17/18.
//  Copyright © 2018 Sean Allen. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }
    
    
    func setupGameScene() {
        let scene = GameScene(size: CGSize(width: 1080, height: 1920))
        scene.scaleMode = .aspectFill
        skView = self.view as? SKView
        skView.presentScene(scene)
    }
}
