//
//  WKWelcomeViewController.h
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCustomViewDismissalProtocol.h"

@interface WKWelcomeViewController : UIViewController

@property (nonatomic, weak) id<WKCustomViewDismissalProtocol> delegate;

@end
