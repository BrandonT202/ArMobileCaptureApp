//
//  Castle.m
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 29/11/2016.
//
//

#import "Castle.h"

@implementation Castle

- (instancetype) init
{
    self = [super init];
    if(self)
    {
        _territoryName = @"";
        _location = nil;
        _castleID = 0;
    }
    return self;
}

-(instancetype) initWithName:(NSString*) territoryName Location:(CLLocation*) location
{
    
    self = [super init];
    
    if(self)
    {
        _territoryName = territoryName;
        _location = location;
    }
    
    return self;
}

@end
