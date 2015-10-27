//
//  WKViewController.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKCoreViewController.h"
#import "WKSplashController.h"
#import "WKWelcomeViewController.h"
#import "WKKonfiSummaryViewController.h"
#import "WKAppDelegate.h"


@interface WKCoreViewController () <WKCustomViewDismissalProtocol>

@property (nonatomic, strong) WKSplashController *splashController;
@property (nonatomic, strong) WKWelcomeViewController *welcomeController;
@property (nonatomic, strong) WKKonfiSummaryViewController *konfiSummaryController;

//test

@end

@implementation WKCoreViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.splashController = [[WKSplashController alloc] initWithOnScreenDuration:SPLASH_ON_SCREEN_DURATION];
    self.splashController.delegate = self;
    
    self.welcomeController = [[WKWelcomeViewController alloc] init];
    self.welcomeController.delegate = self;
    
    self.konfiSummaryController = [[WKKonfiSummaryViewController alloc] init];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.view addSubview:self.splashController.view];
}

- (void) showWelcomController
{
    self.welcomeController.view.alpha = 0;
    [self.view addSubview:self.welcomeController.view];
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        self.welcomeController.view.alpha = 1;
    }];
}

- (void) showKonfiSummaryController
{
    self.konfiSummaryController.view.alpha = 0;
    [self.view addSubview:self.konfiSummaryController.view];
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        self.konfiSummaryController.view.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <WKCustomViewDismissalProtocol>

- (void)dismissedViewFromController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[WKSplashController class]]) {
        [self showWelcomController];
    }
    else if ([controller isKindOfClass:[WKWelcomeViewController class]]) {
        [self showKonfiSummaryController];
    }
}

@end
