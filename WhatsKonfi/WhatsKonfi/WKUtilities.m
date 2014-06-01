//
//  WKUtilities.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKUtilities.h"

#define TIME_FORMAT_ISO_DATE @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
#define TIME_FORMAT_TIME @"HH:mm"

static NSDateFormatter *isoDateFormatter = nil;
static NSDateFormatter *niceDateFormatter = nil;

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

+ (void) maskImageWithRoundMask: (UIImageView *) image
{
    UIImage *maskImage = [UIImage imageNamed:@"mask_round"];
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[maskImage CGImage];
    
    mask.frame = CGRectMake(0,0,image.frame.size.width, image.frame.size.height);
    
    image.layer.mask = mask;
    image.layer.masksToBounds = YES;
}

+ (NSArray *) retrieveFakeKonfiInfos
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"konfi_infos" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    
    return dict[@"konfis"];
}

+ (NSDate *) getDateForDateString: (NSString *) dateString
{
    if (!isoDateFormatter) {
        isoDateFormatter = [[NSDateFormatter alloc] init];
        [isoDateFormatter setDateFormat:TIME_FORMAT_ISO_DATE];
    }
    
    return [isoDateFormatter dateFromString: dateString];
}

+ (NSString *) getNiceDateStringFromDate: (NSDate *) date
{
    if (!niceDateFormatter) {
        niceDateFormatter = [[NSDateFormatter alloc] init];
        [niceDateFormatter setDateFormat:TIME_FORMAT_TIME];
    }
    
    return [niceDateFormatter stringFromDate:date];
}

@end
