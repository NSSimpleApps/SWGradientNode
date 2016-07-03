# SWGradientNode

`SWGradientNode` is a subclass of `SKSpriteNode` that draws a sweep gradient around a center point with initial angle.

Place into Podfile
`pod 'SWGradientNode/ObjC'` (`ObjC`-project) or
`pod 'SWGradientNode/Swift'` (`Swift`-project).

Import `#import <SWGradientNode/SWGradientNode.h>`
or `import SWGradientNode`.

This class is suitable for `iOS` and `OSX`.

Usage:

```objc
@implementation YourGradientScene

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    self.backgroundColor = [SKColor someColor];

    NSArray<SKColor *> *colors = ...; // some array of colors 

    SWGradientNode *node =
    [[SWGradientNode alloc] initWithColors:colors
                                 locations:nil // or other locations
                                    bounds:view.bounds
                              gradientType:SWGradientTypeSmooth];

    [self addChild:node];
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    SKView *skView = (SKView *)self.view;

    if (!skView.scene) {

    SmoothGradientScene *smoothGradientScene = [SmoothGradientScene sceneWithSize:skView.bounds.size];
    smoothGradientScene.scaleMode = SKSceneScaleModeAspectFill;

    [skView presentScene:smoothGradientScene];
    }
}
```
Length of locations array must be less by one than length of colors array.

Choose any of these types: `SWGradientTypeSmooth`, `SWGradientTypeStep`.

The center of sweeping gradient between (0.0, 0.0) and (1.0, 1.0).
(0.0, 0.0) is a bottom left corner (`OSX`) or top left corner (`iOS`).
(1.0, 1.0) is a top right (`OSX`) or bottom left corner (`iOS`).
Default is (0.5, 0.5).

The first color of the gradient starts at initial angle in radians between 0 and 2*PI
0 is to the right along the x axis.
All colors are located in counter-clockwise order.
Default is 0.

