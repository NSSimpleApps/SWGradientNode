//
//  SWGradientNode.h
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

@import SpriteKit;

#if TARGET_OS_IPHONE

#define SWPoint CGPoint
#define SWRect CGRect

#elif TARGET_OS_MAC

#define SWPoint NSPoint
#define SWRect NSRect

#endif

/// smooth and step types of gradient
typedef NS_ENUM(NSInteger, SWGradientType) {
    
    SWGradientTypeSmooth,
    SWGradientTypeStep
};

NS_ASSUME_NONNULL_BEGIN

/// smooth and step gradient node
@interface SWGradientNode : SKSpriteNode

- (instancetype)initWithColors:(NSArray<SKColor *> *)colors
                     locations:(nullable NSArray<NSNumber *> *)locations
                        bounds:(SWRect)bounds
                  gradientType:(SWGradientType)gradientType;

/// The center of sweeping gradient between (0.0, 0.0) and (1.0, 1.0).
/// (0.0, 0.0) is a bottom left corner (OSX) or top left corner (iOS).
/// (1.0, 1.0) is a top right (OSX) or bottom left corner (iOS).
/// Default is (0.5, 0.5)
@property (assign, nonatomic) SWPoint center;

/// The first color of the gradient starts at this angle in radians between 0 and 2*PI
/// 0 is to the right along the x axis.
/// All colors are located in counter-clockwise order.
/// Default is 0
@property (assign, nonatomic) CGFloat startAngle;

/// The inner radius of the gradient
/// Node will not draw any gradient inside circle with this radius
/// Value between 0 and 0.5
/// Default is 0
@property (assign, nonatomic) CGFloat innerRadius;

@end

NS_ASSUME_NONNULL_END