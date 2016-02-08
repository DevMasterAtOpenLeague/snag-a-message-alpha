//
//  RoundImageView.swift
//  snag-a-message
//
//  Created by Romaine on 2/7/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.greenColor().setFill()
        path.fill()
    }


}
