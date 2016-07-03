//
//  SmoothGradientScene.m
//  SWGradientNodeObjC
//
//  Created by NSSimpleApps on 03.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "SmoothGradientScene.h"
#import "SWGradientNode.h"

@implementation SmoothGradientScene

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
                                                     gradientType:SWGradientTypeSmooth];    
    [self addChild:node];
}

@end
