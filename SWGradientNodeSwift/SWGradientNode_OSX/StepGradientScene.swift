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
        
        self.backgroundColor = SKColor.whiteColor()
        
        let colors =
            [SKColor(iRed: 247, iGreen: 24, iBlue: 34),
             SKColor(iRed: 65, iGreen: 185, iBlue: 86),
             SKColor(iRed: 62, iGreen: 44, iBlue: 222)
        ]
        
        let locations: [Float]? = nil//[0.25, 0.5, 0.75]
        
        let gradientNode = SWGradientNode(colors: colors, locations: locations, bounds: view.bounds, gradientType: .Step)
        self.addChild(gradientNode)
    }
}
