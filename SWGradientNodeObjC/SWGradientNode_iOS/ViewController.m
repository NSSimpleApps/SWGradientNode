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

@property (weak, nonatomic) IBOutlet SKView *skView;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
        
    if (!self.skView.scene) {
        
        SmoothGradientScene *smoothGradientScene = [SmoothGradientScene sceneWithSize:self.skView.bounds.size];
        smoothGradientScene.scaleMode = SKSceneScaleModeAspectFill;//SKSceneScaleModeResizeFill;
        
        [self.skView presentScene:smoothGradientScene];
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

- (IBAction)sender:(UISlider *)sender {
    
    SmoothGradientScene *scene = (SmoothGradientScene *)self.skView.scene;
    
    CGPoint center = CGPointMake(0.5, 0.5);
    
    SWGradientNode *node = (SWGradientNode *)[scene nodeAtPoint:center];
    node.innerRadius = sender.value;
}

@end
