//
//  WKWelcomeViewController.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKWelcomeViewController.h"
#import "WKSystemCenter.h"
#import "WKUtilities.h"


@interface WKWelcomeViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UILabel *welcomeHeader;
@property (weak, nonatomic) IBOutlet UILabel *welcomeInfo;
@property (weak, nonatomic) NSTimer *dismissalTimer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTextTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImageTopConstraint;

@end

@implementation WKWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[WKSystemCenter defaultCenter] setUserLoginState:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    [WKUtilities maskImageWithRoundMask:self.userImage];
}

- (void) setupUI
{
    if ([[WKSystemCenter defaultCenter] isUserLoggedIn]) {
        self.nameLabel.alpha = 1;
        self.emailTextfield.alpha = 0;
    }
    else {
        self.nameLabel.alpha = 0;
        self.emailTextfield.alpha = 1;
        self.emailTextfield.delegate = self;
    }
    
    self.nameLabel.font = FONT_CRAYON(30);
    self.nameLabel.textColor = COLOR_HIGHLIGHT;
    
    self.welcomeHeader.font = FONT_CRAYON(25);
    self.welcomeHeader.textColor = COLOR_HIGHLIGHT;
    self.welcomeInfo.font = FONT_CRAYON_DEFAULT;
    self.welcomeInfo.textColor = COLOR_HIGHLIGHT;
    
    if ([WKUtilities is4inchPhone]) {
        self.userImageTopConstraint.constant = 100;
    }
}

- (void) doLogin
{
    //call backend and retrieve username
    //save username to userdefaults
    
    self.nameLabel.text = [[WKSystemCenter defaultCenter] userName];
    
#warning just for testing until backend connection is established
    [self.userImage setImage:[UIImage imageNamed:@"manu_rot.jpeg"]];
    
    [self showLoginTransition];
}

- (void) showLoginTransition
{
    self.dismissalTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissAnimatedFromScreen) userInfo:nil repeats:NO];
                           
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        self.emailTextfield.alpha = 0;
        self.welcomeHeader.alpha = 0;
        self.welcomeInfo.alpha = 0;
        self.nameLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION*2 animations:^{
                CGRect frame = self.userImage.frame;
                frame.origin.y += 50;
                self.userImage.frame = frame;
            }];
            [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
                CGRect frame = self.nameLabel.frame;
                frame.origin.y += 70;
                self.nameLabel.frame = frame;
            }];
        }
    }];
}

- (void) dismissAnimatedFromScreen
{
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION*2 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = -frame.size.width;
        self.view.frame = frame;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self.dismissalTimer invalidate];
        self.dismissalTimer = nil;
        
        [self.delegate dismissedViewFromController:self];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - <UITextFieldDelegate>

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^{
        self.welcomeInfo.alpha = 0;
        self.welcomeHeader.alpha = 0;
    }];
}
- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [[WKSystemCenter defaultCenter] setUserLoginState:YES];
    [[WKSystemCenter defaultCenter] saveUserEmail:textField.text];
    
    [self doLogin];
    
    [self.emailTextfield resignFirstResponder];
    return YES;
}

@end
