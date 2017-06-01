//
//  ViewController.m
//  SWGradientNode
//
//  Created by NSSimpleApps on 12.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "OSXViewController.h"
@import SpriteKit;
#import "StepGradientScene.h"
#import "SWGradientNode.h"

@interface OSXViewController ()

@property (weak) IBOutlet SKView *skView;

@end

@implementation OSXViewController

- (void)viewDidAppear {
    
    [super viewDidAppear];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!self.skView.scene) {
            
            StepGradientScene *stepGradientScene = [StepGradientScene sceneWithSize:self.skView.bounds.size];
            stepGradientScene.scaleMode = SKSceneScaleModeAspectFill;//SKSceneScaleModeResizeFill;
            
            [self.skView presentScene:stepGradientScene];
        }
    });
}

- (IBAction)handlePanGesture:(NSPanGestureRecognizer *)sender {
    
    SKView *skView = (SKView *)sender.view;
    
    CGPoint point = NSPointToCGPoint([sender locationInView:skView]);
    
    SKNode *skNode = [skView.scene nodeAtPoint:point];
    
    if ([skNode isKindOfClass:[SWGradientNode class]]) {
        
        SWGradientNode *node = (SWGradientNode *)skNode;
        node.center = NSMakePoint(point.x/skView.frame.size.width, point.y/skView.frame.size.height);
    }
}

- (IBAction)innerRadiusChanged:(NSSlider *)sender {
    
    StepGradientScene *scene = (StepGradientScene *)self.skView.scene;
    
    CGPoint center = CGPointMake(0.5, 0.5);
        
    SWGradientNode *node = (SWGradientNode *)[scene nodeAtPoint:center];
    node.innerRadius = sender.floatValue;
}

@end
