//
//  WKBeaconCenter.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 01/06/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ESTIMOTE_PROXIMITY_UUID     [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]



@interface WKBeaconCenter : NSObject

@property (nonatomic, strong) NSArray *myBeacons;

+ (WKBeaconCenter *) defaultCenter;
- (void) startBeaconScan;
- (void) stopBeaconScan;

@end
