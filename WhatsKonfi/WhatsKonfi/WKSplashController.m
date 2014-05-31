//
//  WKSplashController.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKSplashController.h"

@interface WKSplashController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (assign, nonatomic) NSTimeInterval onScreenDuration;
@property (weak, nonatomic) NSTimer *onScreenTimer;

@end

@implementation WKSplashController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithOnScreenDuration: (NSTimeInterval) duration
{
    if (self = [super init]) {
        _onScreenDuration = duration;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.onScreenTimer = [NSTimer scheduledTimerWithTimeInterval:self.onScreenDuration target:self selector:@selector(dismissAnimatedFromScreen) userInfo:nil repeats:NO];
}

- (void) dismissAnimatedFromScreen
{
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION*2 animations:^{
        CGRect frame = self.titleLabel.frame;
        frame.origin.x = -self.titleLabel.frame.size.width;
        self.titleLabel.frame = frame;
        
        self.titleLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
                self.view.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.view removeFromSuperview];
                    [self.onScreenTimer invalidate];
                    self.onScreenTimer = nil;
                    
                    [self.delegate dismissedViewFromController: self];
                }
            }];
        }
    }];
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION*3 animations:^{
        CGRect frame = self.logo.frame;
        frame.origin.x = -self.logo.frame.size.width;
        self.logo.frame = frame;
    }];
}


- (void) setupUI
{
    self.titleLabel.font = FONT_CRAYON(45);
    self.titleLabel.textColor = COLOR_HIGHTLIGHT;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
