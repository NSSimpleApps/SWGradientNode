//
//  SWGradientNode.m
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "SWGradientNode.h"
#import "SWGradientShader.h"

#if TARGET_OS_IPHONE

#define SWPointMake CGPointMake

#define SWRectGetMidX CGRectGetMidX
#define SWRectGetMidY CGRectGetMidY

#elif TARGET_OS_MAC

#define SWPointMake NSMakePoint

#define SWRectGetMidX NSMidX
#define SWRectGetMidY NSMidY

#endif

static NSString *const SWUniformColor = @"uniformColor";
static NSString *const SWUniformLocation = @"uniformLocation";

@interface SWGradientNode ()

@property (strong) SKUniform *uniformCenter;

@property (strong) SKUniform *uniformStartAngle;

@property (strong) SKUniform *uniformInnerRadius;

@end

@implementation SWGradientNode

- (instancetype)initWithColors:(NSArray<SKColor *> *)colors
                     locations:(NSArray<NSNumber *> *)locations
                        bounds:(SWRect)bounds
                  gradientType:(SWGradientType)gradientType {
    
    self = [super initWithTexture:nil
                            color:[SKColor clearColor]
                             size:bounds.size];
    
    if (self) {
        
        self.uniformCenter = [SKUniform uniformWithName:@"uniformCenter"
                                           floatVector2:GLKVector2Make(0.5, 0.5)];
        self.uniformStartAngle = [SKUniform uniformWithName:@"uniformStartAngle" float: 0.0];
        self.uniformInnerRadius = [SKUniform uniformWithName:@"uniformInnerRadius" float: 0.0];
        
        self.position = SWPointMake(SWRectGetMidX(bounds), SWRectGetMidY(bounds));
        
        if (colors.count == 1) {
            
            self.color = colors[0];
            
        } else {
            
            NSMutableArray<SKUniform *> *uniforms = [NSMutableArray arrayWithObjects:self.uniformCenter, self.uniformStartAngle, self.uniformInnerRadius, nil];
            
            [colors enumerateObjectsUsingBlock:^(SKColor * _Nonnull color, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CGFloat red = 0, green = 0, blue = 0, alpha = 0;
                
                [color getRed:&red green:&green blue:&blue alpha:&alpha];
                
                GLKVector4 vector4 = GLKVector4Make(red, green, blue, alpha);
                
                SKUniform *colorUniform = [SKUniform uniformWithName:[NSString stringWithFormat:@"%@%@", SWUniformColor, @(idx)]
                              floatVector4:vector4];
                
                [uniforms addObject:colorUniform];
            }];
            
            if (locations != nil && ((locations.count - 1) == colors.count)) {
                
                [locations enumerateObjectsUsingBlock:^(NSNumber * _Nonnull location, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSString *name = [NSString stringWithFormat:@"%@%@", SWUniformLocation, @(idx + 1)];
                    
                    SKUniform *locationUniform = [SKUniform uniformWithName:name
                                                                      float:location.floatValue];
                    [uniforms addObject:locationUniform];
                }];
                
            } else {
                
                for (NSUInteger elem = 1; elem < colors.count; elem++) {
                    
                    NSString *name = [NSString stringWithFormat:@"%@%@", SWUniformLocation, @(elem)];
                    
                    CGFloat location = (float)elem/colors.count;
                    
                    SKUniform *locationUniform = [SKUniform uniformWithName:name
                                                                      float:location];
                    [uniforms addObject:locationUniform];
                }
            }
            
            SWGradientShader *gradientShader = nil;
            
            if (gradientType == SWGradientTypeSmooth) {
                
                gradientShader =
                [[SWSmoothGradientShader alloc ] initWithColor:SWUniformColor
                                                      location:SWUniformLocation
                                                        center:self.uniformCenter.name
                                                    startAngle:self.uniformStartAngle.name
                 innerRadius:self.uniformInnerRadius.name];
                
            } else if (gradientType == SWGradientTypeStep) {
                
                gradientShader =
                [[SWStepGradientShader alloc ] initWithColor:SWUniformColor
                                                    location:SWUniformLocation
                                                      center:self.uniformCenter.name
                                                  startAngle:self.uniformStartAngle.name
                 innerRadius:self.uniformInnerRadius.name];
            }
            
            self.shader = [[SKShader alloc] initWithSource:[gradientShader shaderWithNumberOfColors:colors.count - 1]
                                                  uniforms:uniforms];
        }
    }
    return self;
}

- (SWPoint)center {
    
    GLKVector2 floatVector = self.uniformCenter.floatVector2Value;
    
    CGFloat x = floatVector.x;
    
    #if TARGET_OS_IPHONE
    
        CGFloat y = 1 - MIN(MAX(floatVector.y, 0.0), 1.0);
    
    #elif TARGET_OS_MAC
    
        CGFloat y = MIN(MAX(floatVector.y, 0.0), 1.0);
    #endif

    return SWPointMake(x, y);
}

- (void)setCenter:(SWPoint)center {
    
    CGFloat x = MIN(MAX(center.x, 0.0), 1.0);
    
    #if TARGET_OS_IPHONE
    
    CGFloat y = 1 - MIN(MAX(center.y, 0.0), 1.0);
    
    #elif TARGET_OS_MAC
    
    CGFloat y = MIN(MAX(center.y, 0.0), 1.0);
    
    #endif
    
    self.uniformCenter.floatVector2Value = GLKVector2Make(x, y);
}

- (CGFloat)startAngle {
    
    return self.uniformStartAngle.floatValue;
}

- (void)setStartAngle:(CGFloat)startAngle {
    
    self.uniformStartAngle.floatValue = fmodf(startAngle, 2 * M_PI) / (2 * M_PI);
}


- (CGFloat)innerRadius {
    
    return self.uniformInnerRadius.floatValue;
}

- (void)setInnerRadius:(CGFloat)innerRadius {
    
    self.uniformInnerRadius.floatValue = MIN(MAX(innerRadius, 0.0), 0.5);
}

@end

