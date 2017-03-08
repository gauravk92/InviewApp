//
//  SingleTapGestureRecognizer.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "SingleTapGestureRecognizer.h"

@implementation SingleTapGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        self.minimumPressDuration = 0.01;
    }
    return self;
}

@end
