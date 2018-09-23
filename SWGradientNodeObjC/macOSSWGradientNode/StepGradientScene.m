//
//  StepGradientScene.m
//  SWGradientNodeObjC
//
//  Created by NSSimpleApps on 03.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "StepGradientScene.h"
#import "SWGradientNode.h"
#import "SKColor+Integers.h"

@implementation StepGradientScene

- (void)didMoveToView:(SKView *)view {
    
    [super didMoveToView:view];
    
    self.backgroundColor = [SKColor whiteColor];
    
    NSArray<SKColor *> *colors =
    @[[SKColor colorWithiRed:247 iGreen:24 iBlue:34],
      [SKColor colorWithiRed: 65 iGreen: 185 iBlue: 86],
      [SKColor colorWithiRed: 62 iGreen: 44 iBlue: 222]
      ];
    
    SWGradientNode *node = [[SWGradientNode alloc] initWithColors:colors
                                                        locations:nil
                                                           bounds:view.bounds
                                                     gradientType:SWGradientTypeStep];
    
    [self addChild:node];
}

@end
