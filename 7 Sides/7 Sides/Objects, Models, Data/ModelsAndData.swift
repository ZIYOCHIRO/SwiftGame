//
//  ModelsAndData.swift
//  7 Sides
//
//  Created by 10.12 on 2018/12/5.
//  Copyright © 2018 Rui. All rights reserved.
//

import Foundation
import SpriteKit


// ---------Sides and ball information------

enum colorType {
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Green
    case Purple
}

let colorWheelOrder:[colorType] = [colorType.Red, .Orange, .Pink, .Blue, .Yellow, .Green, .Purple]

var sidePositionArray: [CGPoint] = []

// --------- game state ---------
enum gameState {
    case beforeGame
    case inGame
    case afterGame
}
// --------- physics gategories -----
struct PhysicsCategories {
    static let None: UInt32 = 0 //0
    static let Ball: UInt32 = 0b1 //1
    static let Side: UInt32 = 0b10 //2
}

//---------------- Score system ---------------

var score: Int = 0

// ---------- Level system -------
var ballMovementTime: TimeInterval = 2








