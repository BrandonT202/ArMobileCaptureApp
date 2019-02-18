//
//  ViewController.m
//  ARKit Example
//
//  Created by Carlos on 21/10/13.
//
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *points;
@property (strong, nonatomic) ARKitEngine *engine;

@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) BattleView* currentBattleView;

@property (strong, nonatomic) CADisplayLink* displayLink;
@property (nonatomic) NSTimeInterval lastTimeStamp;

@property (nonatomic) CGFloat currentTime;

@end

@implementation ViewController

- (void) viewDidLoad {
    _selectedIndex = -1;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:51.500622 longitude:-0.126662];
    ARGeoCoordinate *london = [ARGeoCoordinate coordinateWithLocation:location];
    london.dataObject = @"London";

    location = [[CLLocation alloc] initWithLatitude:40.7058253 longitude:-74.1180861];
    ARGeoCoordinate *newyork = [ARGeoCoordinate coordinateWithLocation:location];
    newyork.dataObject = @"New York";
    
    location = [[CLLocation alloc] initWithLatitude:53.9586419 longitude:-1.1156109];
    ARGeoCoordinate *york = [ARGeoCoordinate coordinateWithLocation:location];
    york.dataObject = @"York";
    
    location = [[CLLocation alloc] initWithLatitude:53.6927387 longitude:-2.5073066];
    ARGeoCoordinate *darwen = [ARGeoCoordinate coordinateWithLocation:location];
    darwen.dataObject = @"Darwen";
    
    location = [[CLLocation alloc] initWithLatitude:54.569226 longitude:-1.231618];
    ARGeoCoordinate *local = [ARGeoCoordinate coordinateWithLocation:location];
    local.dataObject = @"Local Street";
    
    _points = @[london, local, newyork, york, darwen];

    //Start Display Link Loop
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (IBAction)showAR:(id)sender
{
    ARKitConfig *config = [ARKitConfig defaultConfigFor:self];
    config.debugMode = YES;
    config.orientation = self.interfaceOrientation;
    
    CGSize s = [UIScreen mainScreen].bounds.size;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        config.radarPoint = CGPointMake(s.width - 50, s.height - 50);
    }
    else
    {
        config.radarPoint = CGPointMake(s.height - 50, s.width - 50);
    }
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    [closeBtn addTarget:self action:@selector(closeAr) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.center = CGPointMake(25, 25);
    
    _engine = [[ARKitEngine alloc] initWithConfig:config];
    [_engine addCoordinates:_points];
    [_engine addExtraView:closeBtn];
    [_engine startListening];
}

- (void) closeAr
{
    NSLog(@"%s", "Log: Closing Ar");
    [_engine hide];
}

#pragma mark - AR Update Loop

-(void) update:(CADisplayLink *)display
{
    if(display.timestamp == 0)
    {
        return;
    }
    
    CGFloat elapsedTime = display.timestamp - _lastTimeStamp;
    _currentTime += elapsedTime;
    _lastTimeStamp = display.timestamp;
    
    if(_currentTime > TICK_LENGTH)
    {
        //Update game
//        NSLog(@"%@%g",@"Update:", elapsedTime);
        
        //Update view
        [_currentBattleView update:elapsedTime];
        _currentTime = 0.0f;
    }
}

#pragma mark - ARViewDelegate protocol Methods

- (ARObjectView *)viewForCoordinate:(ARGeoCoordinate *)coordinate floorLooking:(BOOL)floorLooking
{
    NSString *text = (NSString *)coordinate.dataObject;
    
    ARObjectView *view = nil;
    
    if (floorLooking)
    {
        UIImage *arrowImg = [UIImage imageNamed:@"arrow.png"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrowImg];
        view = [[ARObjectView alloc] initWithFrame:arrowView.bounds];
        [view addSubview:arrowView];
        view.displayed = YES;
    }
    else
    {
        UIImageView *boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"castle.png"]];
        boxView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        NSInteger offset =64;
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake((boxView.frame.size.width / 2) - offset, boxView.frame.size.height / 2, boxView.frame.size.width / 2, offset/4)];
        lbl.font = [UIFont systemFontOfSize:17];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor whiteColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = text;
        lbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        view = [[ARObjectView alloc] initWithFrame:boxView.frame];
        [view addSubview:boxView];
        [view addSubview:lbl];
    }
    
    [view sizeToFit];
    return view;
}

- (void) itemTouchedWithIndex:(NSInteger)index
{
    _selectedIndex = index;
    NSString *name = (NSString *)[_engine dataObjectWithIndex:index];
    _currentBattleView = [[NSBundle mainBundle] loadNibNamed:@"BattleView" owner:nil options:nil][0];
    _currentBattleView.nameLabel.text = [[NSString alloc] initWithFormat:@"%s%@", "Battling for:", name];
    [_engine addExtraView:_currentBattleView];
}

- (void) didChangeLooking:(BOOL)floorLooking
{
    if (floorLooking)
    {
        if (_selectedIndex != -1)
        {
            [_currentBattleView removeFromSuperview];
            ARObjectView *floorView = [_engine floorViewWithIndex:_selectedIndex];
            floorView.displayed = YES;
        }
    }
    else
    {
        if (_selectedIndex != -1)
        {
            ARObjectView *floorView = [_engine floorViewWithIndex:_selectedIndex];
            floorView.displayed = NO;
            _selectedIndex = -1;
        }
    }
}

@end
