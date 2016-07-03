//
//  StepGradientScene.swift
//  SWGradientNodeSwift
//
//  Created by NSSimpleApps on 03.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import SpriteKit

class StepGradientScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        //self.backgroundColor = SKColor.whiteColor()
        
        let colors =
            [SKColor.redColor(),
             SKColor.greenColor(),
             SKColor.blueColor(),
             SKColor.yellowColor()
        ]
        
        let locations: [Float]? = nil//[0.25, 0.5, 0.75]
        
        let gradientNode = SWGradientNode(colors: colors, locations: locations, bounds: view.bounds, gradientType: .Step)
        self.addChild(gradientNode)
    }
}
