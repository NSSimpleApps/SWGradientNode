//
//  SmoothGradientScene.swift
//  SWGradientNodeSwift
//
//  Created by NSSimpleApps on 03.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import SpriteKit

class SmoothGradientScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        //self.backgroundColor = SKColor.whiteColor()
        
        let colors =
            [SKColor.redColor(),
             SKColor.greenColor(),
             SKColor.blueColor(),
             SKColor.yellowColor()
        ]
        
        let locations: [Float]? = [0.15, 0.5]//[0.15, 0.5, 0.9]
        
        let gradientNode = SWGradientNode(colors: colors, locations: locations, bounds: view.bounds, gradientType: .Smooth)
        self.addChild(gradientNode)
    }
}
