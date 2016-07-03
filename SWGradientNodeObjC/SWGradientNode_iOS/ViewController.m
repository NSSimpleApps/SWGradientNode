//
//  ViewController.m
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "ViewController.h"
#import "SmoothGradientScene.h"
#import "SWGradientNode.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    SKView *skView = (SKView *)self.view;
        
    if (!skView.scene) {
                
        SmoothGradientScene *smoothGradientScene = [SmoothGradientScene sceneWithSize:skView.bounds.size];
        smoothGradientScene.scaleMode = SKSceneScaleModeAspectFill;//SKSceneScaleModeResizeFill;
        
        [skView presentScene:smoothGradientScene];
    }
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    
    SKView *skView = (SKView *)sender.view;
    
    CGPoint point = [sender locationInView:skView];
    
    SKNode *skNode = [skView.scene nodeAtPoint:point];
    
    if ([skNode isKindOfClass:[SWGradientNode class]]) {
        
        SWGradientNode *node = (SWGradientNode *)skNode;
        node.center = CGPointMake(point.x/skView.frame.size.width, point.y/skView.frame.size.height);
    }
}

- (IBAction)handleRotationGesture:(UIRotationGestureRecognizer *)sender {
    
    SKView *skView = (SKView *)sender.view;
    
    CGPoint point = [sender locationInView:skView];
    
    SKNode *skNode = [skView.scene nodeAtPoint:point];
    
    if ([skNode isKindOfClass:[SWGradientNode class]]) {
        
        SWGradientNode *node = (SWGradientNode *)skNode;
        node.startAngle = sender.rotation;
    }
}

@end
