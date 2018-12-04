//
//  GameViewController.swift
//  Space Invaders
//
//  Created by 10.12 on 2018/11/30.
//  Copyright © 2018 Rui. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "backgroundSoundEffect", ofType:"mp3")
        let audioURL = URL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            return print("Cannot find the audio")
        }
        
        backingAudio.numberOfLoops = -1 // play forever
        backingAudio.play()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MainMenuScene(size:CGSize(width: 1536, height: 2048))
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
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
}
