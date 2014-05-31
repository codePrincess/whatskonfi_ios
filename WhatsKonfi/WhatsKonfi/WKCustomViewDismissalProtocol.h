//
//  WKSplashProtocol.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WKCustomViewDismissalProtocol <NSObject>

- (void) dismissedViewFromController: (UIViewController *) controller;

@end
