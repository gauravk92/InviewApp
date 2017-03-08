//
//  ControlBarModel.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ControlBarModel.h"

@implementation NewsHeadlineItem

@end

@interface ControlBarModel ()

@property (nonatomic, assign) float volumeSetting;
@property (nonatomic, assign) CGFloat brightnessSetting;
@property (nonatomic, strong) NSMutableArray *headlines;

@end

@implementation ControlBarModel

- (instancetype)init {
    if ((self = [super init])) {
        _volumeSetting = 0.5;
        _brightnessSetting = 1;
        _headlines = [[NSMutableArray alloc] initWithCapacity:50];
        
    }
    return self;
}

- (void)setup {
    if (self.delegate != nil) {
        [self.delegate viewModelChangedVolume:self.volumeSetting];
        [self.delegate viewModelChangedBrightness:self.brightnessSetting];
        [self.delegate viewModelChangedPaypalString:self.paypalString];
        [self.delegate viewModelChangedVenmoString:self.venmoString];
    } else {
        NSLog(@"ControlBarModel delegate not found. Failed to set initial values.");
    }
}

- (NSUInteger)nextIndexWithHeadline:(NewsHeadlineItem*)dict {
    if (dict == nil) {
        return 0;
    }
    NSUInteger index = [self.headlines indexOfObject:dict];
    if (index == NSNotFound) {
        return 0;
    }
    NSUInteger indexPlusOne = index + 1;
    if (indexPlusOne > self.headlines.count-1) {
        return 0;
    }
    return indexPlusOne;
}

- (NewsHeadlineItem*)nextHeadlineWithHeadline:(NewsHeadlineItem *)item {
    if (item) {
        return [self.headlines objectAtIndex:[self nextIndexWithHeadline:item]];
    }
    return [self.headlines objectAtIndex:0];
}

- (void)updateHeadlines:(NSArray*)array {
    if (array && array.count > 0) {
        [self.headlines removeAllObjects];
//        [self.headlines addObjectsFromArray:array];
        for (NSDictionary *item in array) {
            NewsHeadlineItem *newsItem = [NewsHeadlineItem new];
            newsItem.headline = [item objectForKey:@"headline"];
            NSString *site = [[item objectForKey:@"site"] uppercaseString];
            NSString *formatSite = [site stringByReplacingOccurrencesOfString:@"-" withString:@" "];
            
            if ([formatSite isEqualToString:@"THE NEW YORK TIMES"]) {
                formatSite = @"NY TIMES";
            }
            
            if ([formatSite isEqualToString:@"THE HUFFINGTON POST"]) {
                formatSite = @"HUFFINGTON POST";
            }
            
            newsItem.site = formatSite;
            [self.headlines addObject:newsItem];
        }
        [self.headlines shuffle];
        if (self.delegate != nil) {
            [self.delegate viewModelChangedHeadlines];
        }
    }
}

- (void)updateWeatherString:(NSString*)string {
    if (string) {
        self.weatherString = [string stringByAppendingString:@"°"];
        if (self.delegate != nil) {
            [self.delegate viewModelChangedWeatherString:self.weatherString];
        }
    }
}

- (void)updateLocation:(CLLocation*)location {
    if (location) {
        self.location = location;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedLocation:location];
        }
    }
}

- (void)updatePaypalString:(NSString*)string {
    if (string) {
        self.paypalString = string;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedPaypalString:self.paypalString];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    }
}

- (void)updateVenmoString:(NSString*)string {
    if (string) {
        self.venmoString = string;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedVenmoString:self.venmoString];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    }
}

- (void)volumeUp {
    [self changeVolume:-1 upOrDown:true];
}

- (void)volumeDown {
    [self changeVolume:-1 upOrDown:false];
}

- (void)brightnessUp {
    [self changeBrightness:-1 upOrDown:true];
}

- (void)brightnessDown {
    [self changeBrightness:-1  upOrDown:false];
}

- (void)changeBrightness:(CGFloat)value upOrDown:(bool)direction {
    if (value <= 1 && value >= 0) {
        self.brightnessSetting = value;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedBrightness:self.brightnessSetting];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    } else {
        CGFloat brightness = self.brightnessSetting;
        if (direction) {
            brightness += 0.2;
        } else {
            brightness -= 0.2;
        }
        
        if (brightness > 1) {
            brightness = 1;
        } else if (brightness < 0) {
            brightness = 0;
        }
        
        self.brightnessSetting = brightness;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedBrightness:self.brightnessSetting];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    }
}

- (void)changeVolume:(float)value upOrDown:(bool)direction {
    if (value <= 1 && value >= 0) {
        self.volumeSetting = value;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedVolume:self.volumeSetting];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    } else {
        float volume = self.volumeSetting;
        
        if (direction) {
            volume += 0.12;
        } else {
            volume -= 0.08;
        }
        
        if (volume > 1) {
            volume = 1;
        } else if (volume < 0.1) {
            volume = 0.1;
        }
        
        self.volumeSetting = volume;
        if (self.delegate != nil) {
            [self.delegate viewModelChangedVolume:self.volumeSetting];
        } else {
            NSLog(@"ControlBarModel delegate not found. Failed to set value!");
        }
    }
}

@end
