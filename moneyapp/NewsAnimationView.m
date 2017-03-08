//
//  NewsAnimationView.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "NewsAnimationView.h"

@interface NewsAnimationView ()

@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *rightLayer;

@end

@implementation NewsAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        _leftLayer = [CALayer layer];
        _leftLayer.masksToBounds = true;
        
        _rightLayer = [CALayer layer];
        _rightLayer.masksToBounds = true;
    }
    return self;
}

@end
