//
//  SWGradientShader.m
//  SWGradientNode
//
//  Created by NSSimpleApps on 05.06.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "SWGradientShader.h"

#if TARGET_OS_IPHONE

static NSString *const SWPrefix = @"highp float; const float M_PI = 3.1415926535897932384626433832795; void main() {";

#elif TARGET_OS_MAC

static NSString *const SWPrefix = @"highp float; __constant float M_PI = 3.1415926535897932384626433832795; void main() {";

#endif

static NSString *const SWPostfix = @"gl_FragColor = color;}";


@implementation SWGradientShader

- (instancetype)initWithColor:(NSString *)uColor
                     location:(NSString *)uLocation
                       center:(NSString *)uCenter
                   startAngle:(NSString *)uStartAngle
                  innerRadius:(NSString *)uInnerRadius {
    
    self = [super init];
    
    if (self) {
        self.uColor = uColor;
        self.uLocation = uLocation;
        self.uCenter = uCenter;
        self.uStartAngle = uStartAngle;
        self.uInnerRadius = uInnerRadius;
    }
    return self;
}

- (NSString *)shaderWithNumberOfColors:(NSInteger)numberOfColors {
    NSString *coordDefinition = [NSString stringWithFormat:@"vec2 coord = v_tex_coord.xy - %@;", self.uCenter];
    //@"if(length(coord) < %@){discard;}\n"
    NSString *angleDefinition = [NSString stringWithFormat:@"if(length(coord) < %@){discard;}\nfloat angle = atan(coord.y, coord.x); if(coord.y < 0.0) {angle = 2.0 * M_PI + angle;} angle = mod(angle / (2.0 * M_PI) + %@, 1.0);", self.uInnerRadius, self.uStartAngle];
    NSString *colorDefinition = [NSString stringWithFormat:@"vec4 color = mix(%@0, %@1, %@);", self.uColor, self.uColor, [self initialStep]];
    NSMutableString *steps = [NSMutableString string];
    
    for (NSInteger index = 2; index <= numberOfColors; index++) {
        [steps appendFormat:@"color = mix(color, %@%@, %@);\n", self.uColor, @(index), [self stepForIndex:index]];
    }
    NSString *lastStep = [NSString stringWithFormat:@"color = mix(color, %@0, %@);", self.uColor, [self lastStepForIndex:numberOfColors]];
    
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@\n%@", SWPrefix, coordDefinition, angleDefinition, colorDefinition, steps, lastStep, SWPostfix];
}

- (NSString *)initialStep {
    return @"";
}

- (NSString *)stepForIndex:(NSInteger)index {
    return @"";
}

- (NSString *)lastStepForIndex:(NSInteger)index {
    return @"";
}

@end

@implementation SWSmoothGradientShader

- (NSString *)initialStep {
    return [NSString stringWithFormat:@"smoothstep(0.0, %@1, angle)", self.uLocation];
}

- (NSString *)stepForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"smoothstep(%@%@, %@%@, angle)", self.uLocation, @(index - 1), self.uLocation, @(index)];
}

- (NSString *)lastStepForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"smoothstep(%@%@, 1.0, angle)", self.uLocation, @(index)];
}

@end


@implementation SWStepGradientShader

- (NSString *)initialStep {
    return [self stepForIndex:1];
}

- (NSString *)stepForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"step(%@%@, angle)", self.uLocation, @(index)];
}

- (NSString *)lastStepForIndex:(NSInteger)index {
    return @"step(1.0, angle)";
}

@end

