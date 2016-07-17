//
//  SWColor+Integers.swift
//  SWGradientNodeSwift
//
//  Created by NSSimpleApps on 17.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import SpriteKit


extension SKColor {
    
    convenience init(iRed: Int, iGreen: Int, iBlue: Int) {
        
        self.init(red: CGFloat(iRed)/255, green: CGFloat(iGreen)/255, blue: CGFloat(iBlue)/255, alpha: 1)
    }
}
