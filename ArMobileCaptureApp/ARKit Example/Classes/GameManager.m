//
//  GameManager.m
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 29/11/2016.
//
//

#import "GameManager.h"


@interface GameManager ()

@property (strong, nonatomic) NSMutableArray* castleList;
@property (strong, nonatomic) Castle* currentTarget;

@end

@implementation GameManager

-(instancetype) init
{
    self = [super init];
    
    if(self)
    {
        return self;
    }
    return self;
}

-(instancetype) initWithTarget: (Castle*) castle {
    
    self = [super init];
    
    if(self)
    {
        _currentTarget = castle;
    }
    
    [_castleList addObject:castle];
    return self;
}

-(void) addCastleToList:(Castle*) castle
{
    NSLog(@"%@%@%@", @"Adding Castle ", castle.territoryName, @" to castle list.");
    [_castleList addObject:castle];
}

@end
