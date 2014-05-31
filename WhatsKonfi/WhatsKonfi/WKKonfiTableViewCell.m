//
//  WKKonfiTableViewCell.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 01/06/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKKonfiTableViewCell.h"

@interface WKKonfiTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *konfiImage;
@property (weak, nonatomic) IBOutlet UIView *contentBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *konfiName;
@property (weak, nonatomic) IBOutlet UILabel *konfiLocation;
@property (weak, nonatomic) IBOutlet UILabel *konfiPeopleBooking;
@property (weak, nonatomic) IBOutlet UIView *bookingProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *konfiPeopleBookingDetails;


@end

@implementation WKKonfiTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    self.contentBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    self.konfiName.textColor = COLOR_HIGHTLIGHT;
    self.konfiName.font = FONT_CRAYON(26);
    self.konfiName.text = @"Konfi Glass";
    
    self.konfiLocation.textColor = COLOR_HIGHTLIGHT;
    self.konfiLocation.font = FONT_CRAYON_DEFAULT;
    self.konfiLocation.text = @"München";
    
    self.konfiPeopleBooking.textColor = COLOR_HIGHTLIGHT;
    self.konfiPeopleBooking.font = FONT_CRAYON(20);
    self.konfiPeopleBooking.text = @"5 Personen  |  13:15 - 16:30";
    
    self.konfiPeopleBookingDetails.textColor = COLOR_HIGHTLIGHT;
    self.konfiPeopleBookingDetails.font = FONT_CRAYON(14);
    self.konfiPeopleBookingDetails.text = @"Anja, Manu, Alex, Klaus, Dirk";
}


@end
