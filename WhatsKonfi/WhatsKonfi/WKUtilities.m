//
//  WKUtilities.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKUtilities.h"

@implementation WKUtilities

+ (BOOL) is4inchPhone
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    if (frame.size.height == 548) {
        return YES;
    }
    return NO;
}


+ (BOOL) isIPad
{
    static BOOL isIpad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIpad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return isIpad;
}

@end
