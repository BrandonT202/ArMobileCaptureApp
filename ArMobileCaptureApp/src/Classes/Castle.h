//
//  Castle.h
//  ARMobileCaptureGame
//
//  Created by THOMAS, BRANDON on 29/11/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Castle : NSObject

@property (nonatomic) NSUInteger castleID;
@property (strong, nonatomic) NSString* territoryName;
@property (strong, nonatomic) CLLocation* location;


@end
