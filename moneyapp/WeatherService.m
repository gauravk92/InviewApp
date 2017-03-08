//
//  WeatherService.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/20/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "WeatherService.h"

@interface WeatherService ()

@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) NSNumberFormatter *tempFormatter;
@property (nonatomic, strong) NSNumberFormatter *weatherInputFormatter;
@end

@implementation WeatherService

- (instancetype)init {
    if ((self = [super init])) {
        _tempFormatter = [NSNumberFormatter new];
        _tempFormatter.numberStyle = NSNumberFormatterNoStyle;
        _tempFormatter.maximumIntegerDigits = 3;
        _tempFormatter.maximumFractionDigits = 0;
    }
    return self;
}

- (void)setup {
    NSLog(@"Weather service setup");
    self.updateTimer = [NSTimer timerWithTimeInterval:60 * 15 target:self selector:@selector(updateWeatherTimerFired:) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.updateTimer forMode:NSRunLoopCommonModes];
    
    
    __weak WeatherService *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf updateWeatherTimerFired:nil];
    });
}

- (void)updateWeatherTimerFired:(NSTimer*)timer {
    if (self.location) {
        
        __weak WeatherService *weakSelf = self;
    
        NSString *baseString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/38c6378d5392ba44c4fae08ce45ab9a2/%f,%f?exclude=minutely,hourly,daily,alerts,flags", self.location.coordinate.latitude, self.location.coordinate.longitude];
        NSURL *baseURL = [[NSURL alloc] initWithString:baseString];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:baseURL];
        [req addValue:@"gzip" forHTTPHeaderField:@"Accept"];
        [req addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
        [req addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:req completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            WeatherService *strongSelf = weakSelf;
            if (error) {
                NSLog(@"error encountered with firecast.io: %@", error);
                return;
            }
            NSData *data = [NSData dataWithContentsOfURL:location];
            @try {
                NSError *jsonErr;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonErr];
                if (!dict) {
                    NSLog(@"error parsing json: %@", jsonErr);
                    return;
                }
                NSNumber *apparentTemperature = [[dict objectForKey:@"currently"] objectForKey:@"apparentTemperature"];
                NSString *value = [strongSelf.tempFormatter stringFromNumber:apparentTemperature];
                
                if (strongSelf.delegate != nil) {
                    NSLog(@"weather updated: %@", value);
                    [self.delegate weatherServiceUpdatedWeatherString:value];
                } else {
                    NSLog(@"ERROR: WeatherService delegate = nil");
                }
                
                
                NSLog(@"dict: %@", dict);
            } @catch (NSException *exception) {
                NSLog(@"exception raised: %@", exception);
            } @finally {
                
            }
        }];
        [task resume];
        
    }
}

- (void)teardown {
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (void)dealloc {
    [self teardown];
}

@end
