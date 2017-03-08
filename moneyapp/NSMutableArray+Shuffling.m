//
//  NSMutableArray+Shuffling.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/22/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//
//  REF: http://stackoverflow.com/a/56656

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle {
    NSUInteger count = [self count];
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
