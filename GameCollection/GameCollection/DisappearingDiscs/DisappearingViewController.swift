//
//  GameViewController.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/14.
//  Copyright © 2019 Rui. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class DisappearingDiscsViewController: UIViewController, DiscGameDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            scene.gamedelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    
    
 


    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK:- Game Delegate
    func exitGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateInitialViewController()!
        
        self.present(gameViewController, animated: true)
    }
}
