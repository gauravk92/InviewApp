//
//  ControlBarController.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlBarController : UIViewController <TeardownProtocol>


- (void)viewModelChangedVolume:(float)volume;
- (void)viewModelChangedBrightness:(CGFloat)brightness;
- (void)viewModelChangedPaypalString:(NSString*)string;
- (void)viewModelChangedVenmoString:(NSString*)string;
- (void)viewModelChangedLocation:(CLLocation*)location;
- (void)viewModelChangedWeatherString:(NSString*)string;

- (void)weatherServiceUpdatedWeatherString:(NSString*)string;

- (void)viewModelChangedHeadlines;

@end
