//
//  ViewController.swift
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import Cocoa
import SpriteKit

class OSXViewController: NSViewController {
    
    @IBOutlet weak var skView: SKView!
    
    override func viewDidAppear() {
        
        super.viewDidAppear()
        
        DispatchQueue.main.async { 
            
            let gradientScene = StepGradientScene()
            gradientScene.size = self.skView.bounds.size
            gradientScene.scaleMode = .aspectFill
            
            self.skView.presentScene(gradientScene)
        }
    }
    
    @IBAction func handlePanGesture(_ sender: NSPanGestureRecognizer) {
        
        if let skView = sender.view as? SKView, let scene = skView.scene as? StepGradientScene {
            
            let location = sender.location(in: skView)
            
            let center = NSPoint(x: location.x/skView.bounds.width, y: location.y/skView.bounds.height)
            
            let node = scene.atPoint(location) as! SWGradientNode
            node.center = center
        }
    }
    
    @IBAction func innerRadiusChanged(_ sender: NSSlider) {
        
        if let scene = self.skView.scene as? StepGradientScene {
            
            let center = CGPoint(x: 0.5, y: 0.5)
            
            let node = scene.atPoint(center) as! SWGradientNode
            node.innerRadius = sender.floatValue
        }
    }
}
