//
//  BatteryService.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/20/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "BatteryService.h"

@interface BatteryService ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, assign) float lastBatteryLevel;
@end

@implementation BatteryService

- (instancetype)init {
    if ((self = [super init])) {
        
        _numberFormatter = [NSNumberFormatter new];
        _numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
        _numberFormatter.maximumFractionDigits = 1;
        
    
        [self setup];
    }
    return self;
}

- (void)setup {
    [UIDevice currentDevice].batteryMonitoringEnabled = true;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(batteryStateChange:) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [nc addObserver:self selector:@selector(batteryLevelChange:) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
}

- (void)teardown {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)batteryStateChange:(NSNotification*)notif {
    [self updateBatteryData];
}

- (void)batteryLevelChange:(NSNotification*)notif {
//    if (self.lastBatteryLevel)
}

- (void)updateBatteryData {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = true;
    self.lastBatteryLevel = device.batteryLevel;
    NSString *level = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.lastBatteryLevel]];
    
    UIDeviceBatteryState state = device.batteryState;
    NSInteger stateInt = -1;
    if (state == UIDeviceBatteryStateCharging) {
        stateInt = 0;
    } else if (state == UIDeviceBatteryStateFull) {
        stateInt = 1;
    } else if (state == UIDeviceBatteryStateUnknown) {
        stateInt = 2;
    } else if (state == UIDeviceBatteryStateUnplugged) {
        stateInt = 3;
    }
}

- (void)dealloc {
    [self teardown];
}

@end
