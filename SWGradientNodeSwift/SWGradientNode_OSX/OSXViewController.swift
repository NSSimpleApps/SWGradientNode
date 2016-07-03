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
    
    override func viewDidAppear() {
        
        super.viewDidAppear()
        
        dispatch_async(dispatch_get_main_queue()) { 
            
            let gradientScene = StepGradientScene()
            gradientScene.size = self.view.bounds.size
            //gradientScene.scaleMode = .AspectFill
            
            (self.view as! SKView).presentScene(gradientScene)
        }
    }
    
    @IBAction func handlePanGesture(sender: NSPanGestureRecognizer) {
        
        if let skView = sender.view as? SKView, let scene = skView.scene as? StepGradientScene {
            
            let location = sender.locationInView(skView)
            
            let center = NSPoint(x: location.x/skView.bounds.width, y: location.y/skView.bounds.height)
            
            let node = scene.nodeAtPoint(location) as! SWGradientNode
            node.center = center
        }
    }
}
