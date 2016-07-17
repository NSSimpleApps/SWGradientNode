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
    
    @IBOutlet weak var skView: SKView!
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let gradientScene = SmoothGradientScene()
        gradientScene.size = self.skView.bounds.size
        gradientScene.scaleMode = .AspectFill
        
        self.skView.presentScene(gradientScene)
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
    
    @IBAction func innerRadiusChanged(sender: UISlider) {
        
        if let scene = self.skView.scene as? SmoothGradientScene {
            
            let center = CGPoint(x: 0.5, y: 0.5)
            
            let node = scene.nodeAtPoint(center) as! SWGradientNode
            node.innerRadius = sender.value
        }
    }
}

