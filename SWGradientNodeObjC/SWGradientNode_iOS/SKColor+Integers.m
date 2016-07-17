//
//  SKColor+Integers.m
//  SWGradientNodeObjC
//
//  Created by NSSimpleApps on 17.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "SKColor+Integers.h"

@implementation SKColor (Integers)

+ (instancetype)colorWithiRed:(NSInteger)iRed
                       iGreen:(NSInteger)iGreen
                        iBlue:(NSInteger)iBlue {
    
    return [self colorWithRed:(CGFloat)iRed/255.0
                        green:(CGFloat)iGreen/255.0
                         blue:(CGFloat)iBlue/255.0
                        alpha:1];
}

@end
