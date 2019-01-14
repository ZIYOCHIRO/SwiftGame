//
//  UIButtonExtensions.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/14.
//  Copyright © 2019 Rui. All rights reserved.
//

import UIKit

extension UIButton {

    func createFloatingActionButton() {
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10 )
    }
}
