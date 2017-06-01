//
//  SweepGradientNode.swift
//  SweepGradient
//
//  Created by NSSimpleApps on 22.05.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import SpriteKit

#if os(iOS)
    public typealias SWPoint = CGPoint
    public typealias SWRect = CGRect
    
#elseif os(OSX)
    public typealias SWPoint = NSPoint
    public typealias SWRect = NSRect
#endif

private let SWUniformColor = "uniformColor"
private let SWUniformLocation = "uniformLocation"

/// smooth and step types of gradient
public enum SWGradientType {
    
    case smooth
    case step
}

/// smooth and step gradient node
open class SWGradientNode: SKSpriteNode {
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let uniformCenter = SKUniform(name: "uniformCenter", float: GLKVector2Make(0.5, 0.5))
    
    /// The center of sweeping gradient between (0.0, 0.0) and (1.0, 1.0).
    /// (0.0, 0.0) is a bottom left corner (OSX) or top left corner (iOS).
    /// (1.0, 1.0) is a top right (OSX) or bottom left corner (iOS).
    /// Default is (0.5, 0.5)
    open var center: SWPoint {
        
        get {
            
            let floatVector = self.uniformCenter.floatVector2Value
            
            let x = CGFloat(floatVector.x)
            
            #if os(iOS)
                let y = 1 - CGFloat(min(max(floatVector.y, 0.0), 1.0))
            #elseif os(OSX)
                let y = CGFloat(min(max(floatVector.y, 0.0), 1.0))
            #endif
            
            return SWPoint(x: x, y: y)
        }
        
        set {
            
            let x = Float(min(max(newValue.x, 0.0), 1.0))
            
            #if os(iOS)
                let y = 1 - Float(min(max(newValue.y, 0.0), 1.0))
            #elseif os(OSX)
                let y = Float(min(max(newValue.y, 0.0), 1.0))
            #endif
            
            self.uniformCenter.floatVector2Value = GLKVector2Make(x, y)
        }
    }
    
    fileprivate let uniformStartAngle = SKUniform(name: "uniformStartAngle", float: 0.0)
    
    /// The first color of the gradient starts at this angle in radians between 0 and 2*PI
    /// 0 is to the right along the x axis.
    /// All colors are located in counter-clockwise order.
    /// Default is 0
    open var startAngle: Float {
        
        get {
            
            return self.uniformStartAngle.floatValue
        }
        
        set {
            
            self.uniformStartAngle.floatValue = fmodf(newValue, 2 * Float.pi) / (2 * Float.pi)
        }
    }
    
    
    fileprivate let uniformInnerRadius = SKUniform(name: "uniformInnerRadius", float: 0.0)
    
    /// The inner radius of the gradient
    /// Node will not draw any gradient inside circle with this radius
    /// Value between 0 and 0.5
    /// Default is 0
    open var innerRadius: Float {
        
        get {
            
            return self.uniformInnerRadius.floatValue
        }
        
        set {
            
            self.uniformInnerRadius.floatValue = Float(min(max(newValue, 0.0), 0.5))
        }
    }
    
    public init(colors: [SKColor], locations: [Float]?, bounds: SWRect, gradientType: SWGradientType) {
        
        super.init(texture: nil, color: SKColor.clear, size: bounds.size)
        
        self.position = SWPoint(x: bounds.midX, y: bounds.midY)
        
        if colors.count == 1 {
            
            self.color = colors[0]
            
        } else {
            
            var uniforms: [SKUniform] = [self.uniformCenter, self.uniformStartAngle, self.uniformInnerRadius]
            
            for (index, color) in colors.enumerated() {
                
                var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
                
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
                let vector4 = GLKVector4Make(Float(red), Float(green), Float(blue), Float(alpha))
                let colorUniform = SKUniform(name: "\(SWUniformColor)\(index)", float: vector4)
                uniforms.append(colorUniform)
            }
            
            if let locations = locations , locations.count - 1 == colors.count {
                
                for (index, location) in locations.enumerated() {
                    
                    let name = "\(SWUniformLocation)\(index + 1)"
                    
                    let locationUniform = SKUniform(name: name, float: location)
                    uniforms.append(locationUniform)
                }
                
            } else {
                
                (1..<colors.count).forEach({ (elem: Int) in
                    
                    let name = "\(SWUniformLocation)\(elem)"
                    
                    let locationUniform = SKUniform(name: name, float: Float(elem)/Float(colors.count))
                    uniforms.append(locationUniform)
                })
            }
            
            let gradientShader: SWGradientShader
            
            switch gradientType {
            
            case .smooth:
                gradientShader =
                SWSmoothGradientShader(uColor: SWUniformColor,
                                       uLocation: SWUniformLocation,
                                       uCenter: self.uniformCenter.name,
                                       uStartAngle: self.uniformStartAngle.name, uInnerRadius: self.uniformInnerRadius.name)
                
            case .step:
                gradientShader =
                    SWStepGradientShader(uColor: SWUniformColor,
                                         uLocation: SWUniformLocation,
                                         uCenter: self.uniformCenter.name,
                                         uStartAngle: self.uniformStartAngle.name, uInnerRadius: self.uniformInnerRadius.name)
            }
            
            self.shader = SKShader(source: gradientShader.shaderWithNumberOfColors(colors.count - 1))
            self.shader?.uniforms = uniforms
        }
    }
}
