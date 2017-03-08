//
//  CLLocation+MilesDistance.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "CLLocation+MilesDistance.h"

@implementation CLLocation (MilesDistance)

- (NSNumber *)distanceInMilesWithLocation:(CLLocation*)loc2 {
    CLLocation *loc1 = self;
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    return [NSNumber numberWithDouble:(distance/1609.344)];
}

@end
