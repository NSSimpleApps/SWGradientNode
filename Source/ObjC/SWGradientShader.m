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

- (instancetype)initWithColor:(NSString *)color
                     location:(NSString *)location
                       center:(NSString *)center
                   startAngle:(NSString *)startAngle {
    
    self = [super init];
    
    if (self) {
        
        self.color = color;
        self.location = location;
        self.center = center;
        self.startAngle = startAngle;
    }
    return self;
}

- (NSString *)shaderWithCount:(NSInteger)count {
    
    NSString *coordDefinition = [NSString stringWithFormat:@"vec2 coord = v_tex_coord.xy - %@;", self.center];
    
    NSString *angleDefinition = [NSString stringWithFormat:@"float angle = atan(coord.y, coord.x); if(coord.y < 0.0) {angle = 2.0 * M_PI + angle;} angle = mod(angle / (2.0 * M_PI) + %@, 1.0);", self.startAngle];
    
    NSString *colorDefinition = [NSString stringWithFormat:@"vec4 color = mix(%@0, %@1, %@);", self.color, self.color, [self initialStep]];
    
    NSMutableString *steps = [NSMutableString string];
    
    for (NSInteger index = 2; index <= count; index++) {
        
        [steps appendFormat:@"color = mix(color, %@%ld, %@);\n", self.color, (long)index, [self stepForIndex:index]];
    }
    
    NSString *lastStep = [NSString stringWithFormat:@"color = mix(color, %@0, %@);", self.color, [self lastStepForIndex:count]];
    
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
    
    return [NSString stringWithFormat:@"smoothstep(0.0, %@1, angle)", self.location];
}

- (NSString *)stepForIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"smoothstep(%@%@, %@%@, angle)", self.location, @(index - 1), self.location, @(index)];
}

- (NSString *)lastStepForIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"smoothstep(%@%@, 1.0, angle)", self.location, @(index)];
}

@end


@implementation SWStepGradientShader

- (NSString *)initialStep {
    
    return [self stepForIndex:1];
}

- (NSString *)stepForIndex:(NSInteger)index {
    
    return [NSString stringWithFormat:@"step(%@%@, angle)", self.location, @(index)];
}

- (NSString *)lastStepForIndex:(NSInteger)index {
    
    return @"step(1.0, angle)";
}

@end

