//
//  ControlBarView.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ControlBarView.h"


@interface ControlBarView ()

@property (nonatomic, strong) MPVolumeView *volumeControl;


@end

@implementation ControlBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _volumeControl = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        [self addSubview:_volumeControl];
        
        _newsHeadlineView = [[NewsHeadlineView alloc] initWithFrame:CGRectZero];
        [self addSubview:_newsHeadlineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.volumeControl.frame = CGRectZero;
    self.volumeControl.clipsToBounds = true;
    
    self.newsHeadlineView.frame = CGRectMake(0, 703, self.bounds.size.width, 768 - 703);
}

- (void)setVolume:(float)value {
    if (value <= 1 && value >= 0) {
        __weak ControlBarView *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            ControlBarView *strongSelf = weakSelf;
            
            for (UIView *view in strongSelf.volumeControl.subviews) {
                if ([view.description containsString:@"MPVolumeSlider"]) {
                    //NOTE: IGNORE WARNINGS, USING PRIVATE METHOD
                    SEL setValueSEL = @selector(setValue:animated:);
                    if ([view respondsToSelector:setValueSEL]) {
                        // found the view
                        UISlider *slider = (UISlider*)view;
                        [slider setValue:value animated:true];
                        // NOTE: IGNORE WARNINGS, USING PRIVATE METHOD
                        [slider performSelector:@selector(_commitVolumeChange)];
                    }
                    return;
                }
            }
        });
    }
}

@end
