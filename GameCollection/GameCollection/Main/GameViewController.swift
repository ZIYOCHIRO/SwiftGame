//
//  GameViewController.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/14.
//  Copyright © 2019 Rui. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var DisappearingView: UIView!
    @IBOutlet weak var SpaceView: UIView!
    @IBOutlet weak var SidesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DisappearingView.addShadowAndRoundedCorners()
        SpaceView.addShadowAndRoundedCorners()
        SidesView.addShadowAndRoundedCorners()

    }
    

}
