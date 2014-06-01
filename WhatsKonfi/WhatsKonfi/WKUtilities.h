//
//  WKUtilities.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUtilities : NSObject

+ (BOOL) is4inchPhone;
+ (BOOL) isIPad;

+ (void) maskImageWithRoundMask: (UIImageView *) image;

+ (NSArray *) retrieveFakeKonfiInfos;

+ (NSDate *) getDateForDateString: (NSString *) dateString;
+ (NSString *) getNiceDateStringFromDate: (NSDate *) date;

@end
