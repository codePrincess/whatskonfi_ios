//
//  WKSystemCenter.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKSystemCenter.h"


NSString * const USER_LOGIN_STATE   =   @"USER_LOGIN_STATE";
NSString * const USER_NAME          =   @"USER_NAME";
NSString * const USER_EMAIL         =   @"USER_EMAIL";

static WKSystemCenter *instance = nil;

@implementation WKSystemCenter

+ (WKSystemCenter *) defaultCenter
{
    if (!instance) {
        instance = [[WKSystemCenter alloc] init];
    }
    return instance;
}

- (id) init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (BOOL) isUserLoggedIn
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_STATE] boolValue];
}

- (void) setUserLoginState: (BOOL) loginState
{
    [[NSUserDefaults standardUserDefaults] setObject:@(loginState) forKey:USER_LOGIN_STATE];
}

- (NSString *) userEmail
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_EMAIL];
}

- (void) saveUserEmail: (NSString *) userEmail
{
    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:USER_EMAIL];
}

- (NSString *) userName
{
    return @"Manuela Schrenk";
    //return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
}

- (void) saveUserName: (NSString *) userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_NAME];
}

@end
