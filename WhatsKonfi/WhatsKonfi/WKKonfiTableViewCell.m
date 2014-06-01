//
//  WKKonfiTableViewCell.m
//  WhatsKonfi
//
//  Created by Manuela Schrenk on 01/06/14.
//  Copyright (c) 2014 BitRoyal. All rights reserved.
//

#import "WKKonfiTableViewCell.h"
#import "WKUtilities.h"
#import <QuartzCore/QuartzCore.h>

@interface WKKonfiTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *konfiImage;
@property (weak, nonatomic) IBOutlet UIView *contentBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *konfiName;
@property (weak, nonatomic) IBOutlet UILabel *konfiLocation;
@property (weak, nonatomic) IBOutlet UILabel *konfiPeopleBooking;
@property (weak, nonatomic) IBOutlet UILabel *konfiPeopleBookingDetails;

@property (assign, nonatomic) CAShapeLayer *contentLayer;

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
    
    [WKUtilities maskImageWithRoundMask:self.konfiImage];
    
    [self drawCircleForElapsedTime];
}

- (void)drawCircleForElapsedTime {
    //Remove the contentLayer to avoid double drawing to get smooth linings
    [self.contentLayer removeFromSuperlayer];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [[self makeCircleAtLocation:self.konfiImage.center radius:self.konfiImage.frame.size.width / 2] CGPath];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = 3.0f;
    
    [self.layer addSublayer:shapeLayer];
    //Save it locally to avoid dobule drawing earlier in the method
    self.contentLayer = shapeLayer;
}

- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:location
                    radius:radius
                startAngle:-M_PI_2 //Startpoint mustbe -M_PI_2 to start at the top point, unless this it would start at 25% angle
                  endAngle:((M_PI *2) * 0.9) - M_PI_2
                 clockwise:YES];
    
    
    return path;
}

@end
