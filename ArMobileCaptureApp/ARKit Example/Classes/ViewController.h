//
//  ViewController.h
//  ARKit Example
//
//  Created by Brandon Thomas 12/12/16
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ARKit.h"
#import "DetailView.h"
#import "BattleView.h"

#define TICK_LENGTH 0.05f

@interface ViewController : UIViewController<ARViewDelegate>

-(void) update: (CADisplayLink*) sender;

@end
