//
//  SingleEventOperationQueue.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "SingleEventOperationQueue.h"

@implementation SingleEventOperationQueue

- (instancetype)init {
    if ((self = [super init])) {
        self.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end
