//
//  roundStartButton.swift
//  Timer
//
//  Created by Zhijie (Jenny) Xu on 8/28/18.
//  Copyright © 2018 Zhijie (Jenny) Xu. All rights reserved.
//

import UIKit

@IBDesignable
class roundStartButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var cornerRaduis: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRaduis
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
