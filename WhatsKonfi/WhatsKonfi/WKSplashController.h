//
//  WKSplashController.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCustomViewDismissalProtocol.h"

@interface WKSplashController : UIViewController

@property (weak, nonatomic) id<WKCustomViewDismissalProtocol> delegate;

- (id) initWithOnScreenDuration: (NSTimeInterval) duration;

@end
