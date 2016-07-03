//
//  ViewController.swift
//  SWGradientNode_iOS
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let gradientScene = SmoothGradientScene()
        gradientScene.size = self.view.bounds.size
        gradientScene.scaleMode = .AspectFill
        
        (self.view as! SKView).presentScene(gradientScene)
    }
    
    @IBAction func handleRotationGesture(sender: UIRotationGestureRecognizer) {
        
        if let skView = sender.view as? SKView, let scene = skView.scene as? SmoothGradientScene {
            
            let location = sender.locationInView(skView)
            
            let node = scene.nodeAtPoint(location) as! SWGradientNode
            node.startAngle = Float(sender.rotation)
        }
    }
    
    @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        if let skView = sender.view as? SKView, let scene = skView.scene as? SmoothGradientScene {
            
            let location = sender.locationInView(skView)
            
            let center = CGPoint(x: location.x/skView.bounds.width, y: location.y/skView.bounds.height)
            
            let node = scene.nodeAtPoint(location) as! SWGradientNode
            node.center = center
        }
    }
}

