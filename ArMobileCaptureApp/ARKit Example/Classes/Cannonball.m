//
//  Cannonball.m
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 13/12/2016.
//
//

#import "Cannonball.h"

@implementation Cannonball

-(instancetype) initWithImage:(UIImage *)image
{
    if(self = [super initWithImage:image])
    {
        _speed = 10.0f;
        _duration = 1.5f;
    }
    
    _hasAnimationComplete = YES;
    
    return self;
}

-(void) animate
{
    CGFloat x = [UIScreen mainScreen].bounds.size.width / 2.0f - 10.0f;
    CGFloat y = [UIScreen mainScreen].bounds.size.height-[self bounds].size.height;
    self.frame = CGRectMake(x,
                            y,
                            [self bounds].size.width,
                            [self bounds].size.height);
    
    CABasicAnimation* myCannonballOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    myCannonballOpacityAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    myCannonballOpacityAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    myCannonballOpacityAnimation.duration = _duration;
    myCannonballOpacityAnimation.removedOnCompletion = YES;
    [[self layer] addAnimation:myCannonballOpacityAnimation forKey:@"opacity"];
    
    CABasicAnimation* myCannonballScaleXAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    myCannonballScaleXAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    myCannonballScaleXAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    myCannonballScaleXAnimation.duration = _duration;
    myCannonballScaleXAnimation.removedOnCompletion = YES;
    
    CABasicAnimation* myCannonballScaleYAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    myCannonballScaleYAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    myCannonballScaleYAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    myCannonballScaleYAnimation.duration = _duration;
    myCannonballScaleYAnimation.removedOnCompletion = YES;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, x, y);
    
    CGPathAddCurveToPoint(path, NULL, x, y, x, y - 50.0f, x,y - 150.0f);
    
    CAKeyframeAnimation* myCannonballPositionAnimation;
    
    myCannonballPositionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    myCannonballPositionAnimation.path = path;
    myCannonballPositionAnimation.duration = _duration;
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:myCannonballOpacityAnimation, myCannonballScaleXAnimation, myCannonballScaleYAnimation, myCannonballPositionAnimation, nil];
    group.duration = _duration;
    group.delegate = self;
    
    [self.layer addAnimation:group forKey:@"Cannonball"];
//    CABasicAnimation* myCannonballFrameAnimation = [CABasicAnimation animationWithKeyPath:@"frame"];
//    myCannonballOpacityAnimation.fromValue = CGRectMake([UIScreen mainScreen].bounds.size.width / 2,
//                                                        [UIScreen mainScreen].bounds.size.height-[self bounds].size.height,
//                                                        [self bounds].size.width,
//                                                        [self bounds].size.height);
//    myCannonballFrameAnimation.toValue = CGRectMake(0,
//                                                    0,
//                                                    [self bounds].size.width,
//                                                    [self bounds].size.height);
//    myCannonballFrameAnimation.duration = _duration;
//    myCannonballFrameAnimation.removedOnCompletion = YES;
//    [[self layer] addAnimation:myCannonballFrameAnimation forKey:@"frame"];
//    
//    [self. animateWithDuration:_duration animations:^
//     {
//         self.frame = CGRectMake(0,
//                                 0,
//                                 [self bounds].size.width,
//                                 [self bounds].size.height);
//     }
//     completion: ^(BOOL finished)
//     {
//         if(finished)
//         {
//            
//         }
//     }];
}

-(void)animationDidStart:(CAAnimation *)anim
{
    _hasAnimationComplete = NO;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        NSLog(@"Animation did stop");
        _hasAnimationComplete = flag;
        [self removeFromSuperview];
    }
    else NSLog(@"Animation did not stop");
}

@end
