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
@property (weak, nonatomic) IBOutlet UIView *proximityIndicator;

@property (strong, nonatomic) NSDictionary *data;

@property (assign, nonatomic) CAShapeLayer *contentLayer;

@end

@implementation WKKonfiTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) fillWithData: (NSDictionary *) data
{
    self.data = data;
    
    self.konfiName.text = self.data[@"name"];
    
    int bookingCount = [self.data[@"booked"] intValue];
    if (bookingCount > 0) {
        NSArray *people = self.data[@"people"];
        
        NSString *bookingDetailText = @"";
        int count = 0;
        for (NSDictionary *person in people) {
            bookingDetailText = [bookingDetailText stringByAppendingString:person[@"name"]];
            if (count < people.count-1) {
                bookingDetailText = [bookingDetailText stringByAppendingString:@", "];
            }
            count++;
        }
        self.konfiPeopleBookingDetails.text = bookingDetailText;
        
        NSString *bookingText = [NSString stringWithFormat:@"%d Personen", bookingCount];
        self.konfiPeopleBooking.text = bookingText;
    }
    else {
        self.konfiPeopleBookingDetails.text = @"";
        self.konfiPeopleBooking.text = @"FREI";
    }
    
    
}

-(void)awakeFromNib
{
    self.contentBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    self.konfiName.textColor = COLOR_HIGHTLIGHT;
    self.konfiName.font = FONT_CRAYON(26);
    
    self.konfiLocation.textColor = COLOR_HIGHTLIGHT;
    self.konfiLocation.font = FONT_CRAYON_DEFAULT;
    
    self.konfiPeopleBooking.textColor = COLOR_HIGHTLIGHT;
    self.konfiPeopleBooking.font = FONT_CRAYON(20);
    self.konfiPeopleBooking.text = @"5 Personen  |  13:15 - 16:30";
    
    self.konfiPeopleBookingDetails.textColor = COLOR_HIGHTLIGHT;
    self.konfiPeopleBookingDetails.font = FONT_CRAYON(14);
    self.konfiPeopleBookingDetails.text = @"Anja, Manu, Alex, Klaus, Dirk";
    
    self.proximityIndicator.backgroundColor = [UIColor clearColor];
    self.proximityIndicator.alpha = 0.5;
    
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

- (void) setProximity:(CLProximity)proximity
{
    switch (proximity)
    {
        case CLProximityUnknown:
        {
            [self fadeProximityIndicatorToColor:[UIColor lightGrayColor]];
            break;
        }
        case CLProximityImmediate:
        {
            [self fadeProximityIndicatorToColor: [UIColor greenColor]];
            break;
        }
        case CLProximityNear:
        {
            [self fadeProximityIndicatorToColor: [UIColor orangeColor]];
            break;
        }
        case CLProximityFar:
        {
            [self fadeProximityIndicatorToColor: [UIColor redColor]];
            break;
        }
        default:
        {
        }
    }
}

- (void) fadeProximityIndicatorToColor: (UIColor *) color
{
    [UIView animateWithDuration:1.2 animations:^{
        self.proximityIndicator.alpha = 0.3;
        self.proximityIndicator.backgroundColor = color;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.proximityIndicator.alpha = 0.8;
            }];
        }
    }];
}


@end
