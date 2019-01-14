//
//  UIViewExtensions.swift
//  GameCollection
//
//  Created by 10.12 on 2019/1/14.
//  Copyright © 2019 Rui. All rights reserved.
//

import UIKit

extension UIView {
    func addShadowAndRoundedCorners() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 15
    }
    

}
