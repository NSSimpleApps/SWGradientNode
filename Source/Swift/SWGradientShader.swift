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
    
    internal var uColor = ""
    internal var uLocation = ""
    internal var uCenter = ""
    internal var uStartAngle = ""
    internal var uInnerRadius = ""
    
    internal init(uColor: String, uLocation: String, uCenter: String, uStartAngle: String, uInnerRadius: String) {
        
        super.init()
        
        self.uColor = uColor
        self.uLocation = uLocation
        self.uCenter = uCenter
        self.uStartAngle = uStartAngle
        self.uInnerRadius = uInnerRadius
    }
    
    internal func shaderWithNumberOfColors(numberOfColors: Int) -> String {
        
        let coordDefinition =
        "vec2 coord = v_tex_coord.xy - \(self.uCenter);"
        
        let angleDefinition = "if(length(coord) < \(self.uInnerRadius)){discard;}\nfloat angle = atan(coord.y, coord.x); if(coord.y < 0.0) {angle = 2.0 * M_PI + angle;} angle = mod(angle / (2.0 * M_PI) + \(self.uStartAngle), 1.0);"
        
        let colorDefinition = "vec4 color = mix(\(self.uColor)0, \(self.uColor)1, \(self.initialStep()));"
        
        var steps = ""
        
        for index in 2.stride(through: numberOfColors, by: 1) {
            
            steps += "color = mix(color, \(self.uColor)\(index), \(self.stepForIndex(index)));\n"
        }
        
        let lastStep = "color = mix(color, \(self.uColor)0, \(self.lastStepForIndex(numberOfColors)));"
        
        return "\(SWPrefix)\n\(coordDefinition)\n\(angleDefinition)\n\(colorDefinition)\n\(steps)\(lastStep)\n\(SWPostfix)"
    }
    
    internal func initialStep() -> String {
        
        return ""
    }
    
    internal func stepForIndex(index: Int) -> String {
        
        return ""
    }
    
    internal func lastStepForIndex(index: Int) -> String {
        
        return ""
    }
}

internal class SWSmoothGradientShader: SWGradientShader {
    
    override func initialStep() -> String {
        
        return "smoothstep(0.0, \(self.uLocation)1, angle)"
    }
    
    override func stepForIndex(index: Int) -> String {
        
        return "smoothstep(\(self.uLocation)\(index - 1), \(self.uLocation)\(index), angle)"
    }
    
    override func lastStepForIndex(index: Int) -> String {
        
        return "smoothstep(\(self.uLocation)\(index), 1.0, angle)"
    }
}

internal class SWStepGradientShader: SWGradientShader {
    
    override func initialStep() -> String {
        
        return self.stepForIndex(1)
    }
    
    override func stepForIndex(index: Int) -> String {
        
        return "step(\(self.uLocation)\(index), angle)"
    }
    
    override func lastStepForIndex(index: Int) -> String {
        
        return "step(1.0, angle)"
    }
}
