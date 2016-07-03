//
//  SWGradientShader.swift
//  SweepGradient
//
//  Created by NSSimpleApps on 29.05.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import Foundation

#if os(iOS)
private let SWPrefix = "highp float; const float M_PI = 3.1415926535897932384626433832795; void main() {"
#elseif os(OSX)
private let SWPrefix = "highp float; __constant float M_PI = 3.1415926535897932384626433832795; void main() {"
#endif

private let SWPostfix = "gl_FragColor = color;}"

internal class SWGradientShader: NSObject {
    
    private var color = ""
    private var location = ""
    private var center = ""
    private var startAngle = ""
    
    init(color: String, location: String, center: String, startAngle: String) {
        
        super.init()
        
        self.color = color
        self.location = location
        self.center = center
        self.startAngle = startAngle
    }
    
    internal func shaderWithCount(count: Int) -> String {
        
        let coordDefinition = String(format: "vec2 coord = v_tex_coord.xy - %@;", self.center)
        
        let angleDefinition = String(format: "float angle = atan(coord.y, coord.x); if(coord.y < 0.0) {angle = 2.0 * M_PI + angle;} angle = mod(angle / (2.0 * M_PI) + %@, 1.0);", self.startAngle)
        
        let colorDefinition = String(format: "vec4 color = mix(%@0, %@1, %@);", self.color, self.color, self.initialStep())
        
        var steps = ""
        
        for index in 2.stride(through: count, by: 1) {
            
            steps += String(format: "color = mix(color, %@\(index), %@);\n", self.color, self.stepForIndex(index))
        }
        
        let lastStep = String(format: "color = mix(color, %@0, %@);", self.color, self.lastStepForIndex(count))
        
        return String(format: "%@\n%@\n%@\n%@\n%@%@\n%@", SWPrefix, coordDefinition, angleDefinition, colorDefinition, steps, lastStep, SWPostfix)
    }
    
    internal func initialStep() -> String {
        
        fatalError(#function + " must be overriden")
    }
    
    internal func stepForIndex(index: Int) -> String {
        
        fatalError(#function + " must be overriden")
    }
    
    internal func lastStepForIndex(index: Int) -> String {
        
        fatalError(#function + " must be overriden")
    }
}

internal class SWSmoothGradientShader: SWGradientShader {
    
    override func initialStep() -> String {
        
        return String(format: "smoothstep(0.0, %@1, angle)", self.location)
    }
    
    override func stepForIndex(index: Int) -> String {
        
        return String(format: "smoothstep(%@\(index - 1), %@\(index), angle)", self.location, self.location)
    }
    
    override func lastStepForIndex(index: Int) -> String {
        
        return String(format: "smoothstep(%@\(index), 1.0, angle)", self.location)
    }
}

internal class SWStepGradientShader: SWGradientShader {
    
    override func initialStep() -> String {
        
        return self.stepForIndex(1)
    }
    
    override func stepForIndex(index: Int) -> String {
        
        return String(format: "step(%@\(index), angle)", self.location)
    }
    
    override func lastStepForIndex(index: Int) -> String {
        
        return "step(1.0, angle)"
    }
}
