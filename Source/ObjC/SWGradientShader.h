//
//  SWGradientShader.h
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWGradientShader : NSObject

@property (copy) NSString *uColor;
@property (copy) NSString *uLocation;
@property (copy) NSString *uCenter;
@property (copy) NSString *uStartAngle;
@property (copy) NSString *uInnerRadius;

- (instancetype)initWithColor:(NSString *)uColor
                     location:(NSString *)uLocation
                       center:(NSString *)uCenter
                   startAngle:(NSString *)uStartAngle
                   innerRadius:(NSString *)uInnerRadius;

- (NSString *)shaderWithNumberOfColors:(NSInteger)numberOfColors;

/// returns an empty string
- (NSString *)initialStep;

/// returns an empty string
- (NSString *)stepForIndex:(NSInteger)index;

/// returns an empty string
- (NSString *)lastStepForIndex:(NSInteger)index;

@end

@interface SWSmoothGradientShader : SWGradientShader

@end

@interface SWStepGradientShader : SWGradientShader

@end

NS_ASSUME_NONNULL_END
