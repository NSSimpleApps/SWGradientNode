//
//  SWColor+Integers.swift
//  SWGradientNodeSwift
//
//  Created by NSSimpleApps on 17.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import SpriteKit

private extension UInt8 {
    
    var percent: CGFloat {
        
        return CGFloat(self)/CGFloat(UInt8.max)
    }
}


extension SKColor {
    
    convenience init(iRed: UInt8, iGreen: UInt8, iBlue: UInt8) {
        
        self.init(red: iRed.percent,
                  green: iGreen.percent,
                  blue: iBlue.percent,
                  alpha: 1)
    }
}
