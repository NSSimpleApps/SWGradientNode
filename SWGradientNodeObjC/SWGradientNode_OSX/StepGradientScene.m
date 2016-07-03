//
//  StepGradientScene.m
//  SWGradientNodeObjC
//
//  Created by NSSimpleApps on 03.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "StepGradientScene.h"
#import "SWGradientNode.h"

@implementation StepGradientScene

- (void)didMoveToView:(SKView *)view {
    
    [super didMoveToView:view];
    
    self.backgroundColor = [SKColor clearColor];
    
    NSArray<SKColor *> *colors = @[[SKColor redColor],
                                   [SKColor greenColor],
                                   [SKColor blueColor],
                                   [SKColor yellowColor]];
    
    SWGradientNode *node = [[SWGradientNode alloc] initWithColors:colors
                                                        locations:nil
                                                           bounds:view.bounds
                                                     gradientType:SWGradientTypeStep];
    
    [self addChild:node];
}

@end
