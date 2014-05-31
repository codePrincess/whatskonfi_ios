//
//  WKKonfiSummaryViewController.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 31/05/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKKonfiSummaryViewController.h"
#import "WKUtilities.h"
#import "WKKonfiTableViewCell.h"

@interface WKKonfiSummaryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

static NSString *identifier_KonfiTableViewCell = @"WKKonfiTableViewCell";

@implementation WKKonfiSummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WKUtilities maskImageWithRoundMask:self.userImage];
    
    self.userNameLabel.font = FONT_CRAYON_DEFAULT;
    self.userNameLabel.textColor = COLOR_HIGHTLIGHT;
    
    UINib *defaultNib = [UINib nibWithNibName:identifier_KonfiTableViewCell bundle: nil];
    [self.tableView registerNib:defaultNib forCellReuseIdentifier:identifier_KonfiTableViewCell];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_KonfiTableViewCell forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
