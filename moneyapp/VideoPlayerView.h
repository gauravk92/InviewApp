//
//  VideoPlayerView.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerView : UIView

@property (nonatomic, assign, readonly) BOOL readyToPlay;
@property (nonatomic, assign, readonly) BOOL playingEnded;
@property (nonatomic, assign) BOOL shouldAutoplay;
@property (nonatomic, strong, readonly) NSURL *model;

- (void)loadAsset:(NSURL*)model;
- (void)play;

@end