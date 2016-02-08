//
//  RoundedBlurEffectView.swift
//  snag-a-message
//
//  Created by Romaine on 2/7/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBlurEffectView: UIVisualEffectView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    
}