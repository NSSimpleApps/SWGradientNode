//
//  SWGradientShader.h
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWGradientShader : NSObject

@property (copy) NSString *color;
@property (copy) NSString *location;
@property (copy) NSString *center;
@property (copy) NSString *startAngle;

- (instancetype)initWithColor:(NSString *)color
                     location:(NSString *)location
                       center:(NSString *)center
                   startAngle:(NSString *)startAngle;

- (NSString *)shaderWithCount:(NSInteger)count;

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


