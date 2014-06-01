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
#import "WKBeaconCenter.h"
#import "ESTBeacon.h"


@interface WKKonfiSummaryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) NSArray *konfiData;
@property (weak, nonatomic) NSTimer *updateTimer;

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
    
    self.userNameLabel.font = FONT_CRAYON(20);
    self.userNameLabel.textColor = COLOR_HIGHTLIGHT;
    
    UINib *defaultNib = [UINib nibWithNibName:identifier_KonfiTableViewCell bundle: nil];
    [self.tableView registerNib:defaultNib forCellReuseIdentifier:identifier_KonfiTableViewCell];
    
    self.konfiData = [WKUtilities retrieveFakeKonfiInfos];
    
    if ([WKBeaconCenter defaultCenter].myBeacons.count > 0) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refreshView) userInfo:nil repeats:YES];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (void) refreshView
{
    self.konfiData = [WKUtilities retrieveFakeKonfiInfos];
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKKonfiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_KonfiTableViewCell forIndexPath:indexPath];
    
    NSDictionary *konfiInfo = self.konfiData[indexPath.row];
    
    [cell fillWithData:konfiInfo];
    
    NSDictionary *konfiBeaconInfo = konfiInfo[@"beacon_info"];
    for (ESTBeacon *beacon in [WKBeaconCenter defaultCenter].myBeacons) {
        if ([[beacon.proximityUUID UUIDString] isEqualToString: konfiBeaconInfo[@"uuid"]] &&
            [[beacon.major stringValue] isEqualToString:konfiBeaconInfo[@"major"]] &&
            [[beacon.minor stringValue] isEqualToString:konfiBeaconInfo[@"minor"]]) {
            [cell setProximity: beacon.proximity];
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.konfiData.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) dealloc
{
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

@end
