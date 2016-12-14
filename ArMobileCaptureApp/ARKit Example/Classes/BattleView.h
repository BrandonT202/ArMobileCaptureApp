//
//  BattleView.h
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 11/12/2016.
//
//

#import <UIKit/UIKit.h>
#import "Cannonball.h"

@interface BattleView : UIView

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) Cannonball* cannonBall;

-(void) update: (CGFloat) deltaTime;

@end
