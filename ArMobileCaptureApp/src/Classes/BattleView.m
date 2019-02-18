//
//  BattleView.m
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 11/12/2016.
//
//

#import "BattleView.h"

@interface BattleView ()

@property (weak, nonatomic) IBOutlet UILabel *actionLogLabel;

@end

@implementation BattleView

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            CGSize s = [UIScreen mainScreen].bounds.size;
            self.frame = CGRectMake(0, 0, s.height, s.width);
        } else {
            self.frame = [UIScreen mainScreen].bounds;
        }
    }
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognised:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRocognised:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeGesture];
    
    _cannonBall = [[Cannonball alloc] initWithImage:[UIImage imageNamed:@"cannonball.png"]];
    _cannonBall.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _cannonBall.alpha = 0.0f;
    
    return self;
}

-(void) update:(CGFloat)deltaTime
{
    //update animations
    
}

- (IBAction)CancelBattle:(UIButton *)sender
{
    _nameLabel.text = @"Cancel Battle";
    [self removeFromSuperview];
}

- (IBAction)TouchRecognised:(UITapGestureRecognizer *)sender
{
    _actionLogLabel.text = @"Touch Rocognised";
    
    if(_cannonBall.hasAnimationComplete)
    {
        NSLog(@"Fire cannon ball at the Castle");
        [self addSubview:_cannonBall];
        _cannonBall.alpha = 0.0f;
        [_cannonBall animate];
    }
}

- (IBAction)SwipeRocognised:(UISwipeGestureRecognizer *)sender
{
    _actionLogLabel.text = @"Swipe Recognised";
    NSLog(@"Fire catapult at the Castle");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
