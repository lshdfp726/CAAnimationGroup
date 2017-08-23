//
//  ViewController.m
//  Plane
//
//  Created by fns on 2017/8/21.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "ViewController.h"


#define S 240.0
@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *plane;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)createBezierPath:(CGPoint)point {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:point];
    [bezierPath addCurveToPoint:CGPointMake(point.x + S, point.y) controlPoint1:CGPointMake(point.x + S /3, point.y + S/3) controlPoint2:CGPointMake(point.x + S * 2 / 3, point.y - S/3)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path        = bezierPath.CGPath;
    pathLayer.fillColor   = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth   = 3.0;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer *planeLayer   = [CALayer layer];
    planeLayer.frame      = CGRectMake(0, 0, 50.0, 64.0);
    planeLayer.position   = point;
    planeLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:planeLayer];
    //animate the ship rotation
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.fillMode             = kCAFillModeForwards;
    animation.keyPath              = @"position";
    animation.delegate             = self;
    animation.path                 = bezierPath.CGPath;
    animation.rotationMode         = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,animation2];
    group.duration = 4.0;
    group.fillMode = kCAFillModeBoth;
    group.removedOnCompletion = NO;
    [planeLayer addAnimation:group forKey:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    [self createBezierPath:point];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// Returns interface orientation masks.
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
