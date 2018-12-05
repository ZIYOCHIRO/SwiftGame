//
//  SideObject.swift
//  7 Sides
//
//  Created by 10.12 on 2018/12/5.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit

class Side: SKSpriteNode {
    
    let type: colorType
    
    init(type: colorType) {
        
        self.type = type
        let sideTexture = SKTexture(imageNamed: "side_\(self.type)")
        super.init(texture: sideTexture, color: .clear, size: sideTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
