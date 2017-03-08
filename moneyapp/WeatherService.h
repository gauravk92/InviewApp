//
//  WeatherService.h
//  moneyapp
//
//  Created by Gaurav Khanna on 9/20/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControlBarController.h"

@interface WeatherService : NSObject <TeardownProtocol>

@property (nonatomic, weak) ControlBarController *delegate;
@property (nonatomic, copy) CLLocation *location;

@end
