//
//  WKKonfiDetailViewController.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 29/07/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKKonfiDetailViewController.h"

@interface WKKonfiDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessoryLabel;

@property (strong, nonatomic) NSDictionary *infoDict;

@end

@implementation WKKonfiDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void) setupWithDict: (NSDictionary *) dict
{
    _infoDict = dict;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.font = FONT_CRAYON(20);
    self.locationLabel.font = FONT_CRAYON(12);
    self.accessoryLabel.font= FONT_CRAYON(16);
    
    self.titleLabel.text = [self.infoDict objectForKey:@"name"];
    self.locationLabel.text = [self.infoDict objectForKey:@"location"];
    self.accessoryLabel.text = [self.infoDict objectForKey:@"accessory"];
}

- (IBAction)backTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
