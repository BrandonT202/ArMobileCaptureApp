//
//  Cannonball.h
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 13/12/2016.
//
//

#import <UIKit/UIKit.h>

@interface Cannonball : UIImageView <CAAnimationDelegate>

@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat duration;

@property (nonatomic) BOOL hasAnimationComplete;

-(void) animate;

@end
