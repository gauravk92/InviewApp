//
//  ControlBarModel.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControlBarController.h"

@interface NewsHeadlineItem : NSObject

@property (nonatomic, copy) NSString *headline;
@property (nonatomic, copy) NSString *site;

@end

@interface ControlBarModel : NSObject

@property (nonatomic, weak) ControlBarController *delegate;
@property (nonatomic, copy) NSString *paypalString;
@property (nonatomic, copy) NSString *venmoString;
@property (nonatomic, copy) CLLocation *location;
@property (nonatomic, copy) NSString *weatherString;

- (void)setup;
- (void)volumeUp;
- (void)volumeDown;
- (void)brightnessUp;
- (void)brightnessDown;

- (void)updatePaypalString:(NSString*)string;
- (void)updateVenmoString:(NSString*)string;

- (void)updateLocation:(CLLocation*)location;
- (void)updateWeatherString:(NSString*)string;

- (void)updateHeadlines:(NSArray*)array;

- (NewsHeadlineItem*)nextHeadlineWithHeadline:(NewsHeadlineItem *)item;

@end
