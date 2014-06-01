//
//  WKBeaconCenter.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 01/06/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKBeaconCenter.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"

@interface WKBeaconCenter () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;

@end

static WKBeaconCenter *instance = nil;

@implementation WKBeaconCenter

+ (WKBeaconCenter *) defaultCenter
{
    if (!instance) {
        instance = [[WKBeaconCenter alloc] init];
    }
    return instance;
}

- (id) init
{
    if (self = [super init]) {
        self.beaconManager = [[ESTBeaconManager alloc] init];
        self.beaconManager.delegate = self;
        self.myBeacons = [NSArray array];
    }
    
    return self;
}

- (void) startBeaconScan
{
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                      identifier:@"EstimoteSampleRegion"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void) stopBeaconScan
{
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void) startMonitoringBeacons
{
    for (ESTBeacon *beacon in self.myBeacons) {
        ESTBeaconRegion *beaconRegion =
            [[ESTBeaconRegion alloc] initWithProximityUUID:beacon.proximityUUID
                                                     major:[beacon.major unsignedIntValue]
                                                     minor:[beacon.minor unsignedIntValue]
                                                identifier:@"RegionIdentifier"];
        [self.beaconManager startMonitoringForRegion: beaconRegion];
    }
}

#pragma mark - <ESTBeaconManagerDelegate>

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    self.myBeacons = beacons;
}

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


@end
