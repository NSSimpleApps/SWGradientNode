Pod::Spec.new do |s|
    s.name         = "SWGradientNode"
    s.version      = "0.7"
    s.summary      = "This is a sweep color gradient."
    s.description  = "SWGradientNode is a subclass of SKSpriteNode that draws a sweep gradient around a center point with initial angle. See the README"
    s.homepage     = "https://github.com/NSSimpleApps/SWGradientNode"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'NSSimpleApps, Sergey Poluyanov' => 'ns.simple.apps@gmail.com' }
    s.source       = { :git => "https://github.com/NSSimpleApps/SWGradientNode.git", :tag => s.version.to_s }
    s.requires_arc = true

    s.frameworks = 'SpriteKit'

    s.platform                  = :ios, '8.0', :osx, '10.10'
    s.swift_version = '5.0'

    s.ios.deployment_target     = '8.0'
    s.osx.deployment_target     = '10.10'

    s.default_subspec = 'ObjC'

    s.subspec 'ObjC' do |objc|
        objc.source_files = "Source/ObjC/*.{h,m}"
        #objc.private_header_files = "Source/ObjC/SWGradientShader.h"
        objc.public_header_files = "Source/ObjC/SWGradientNode.h"
    end

    s.subspec 'Swift' do |swift|
        swift.source_files = "Source/Swift/*.swift"
    end

end
