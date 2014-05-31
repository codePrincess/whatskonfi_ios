//
//  WKSystemCenter.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKSystemCenter : NSObject

+ (WKSystemCenter *) defaultCenter;

- (BOOL) isUserLoggedIn;
- (void) setUserLoginState: (BOOL) loginState;

- (NSString *) userEmail;
- (void) saveUserEmail: (NSString *) userEmail;

- (NSString *) userName;
- (void) saveUserName: (NSString *) userName;

@end
