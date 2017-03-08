//
//  CLLocation+MilesDistance.h
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (MilesDistance)

- (NSNumber *)distanceInMilesWithLocation:(CLLocation*)loc2;

@end
