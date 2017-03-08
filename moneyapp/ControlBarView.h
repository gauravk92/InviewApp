//
//  ControlBarView.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "NewsHeadlineView.h"

@interface ControlBarView : BareBonesView

@property (nonatomic, strong) NewsHeadlineView *newsHeadlineView;

- (void)setVolume:(float)value;

@end
