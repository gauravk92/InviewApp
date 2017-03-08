//
//  ContentView.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ContentView.h"
#import "VideoPlayerView.h"

@interface ContentView ()

@property (nonatomic, strong) VideoPlayerView *playerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) IAContentItem *currentItem;
@property (nonatomic, assign) BOOL isPlaying;

//@property (nonatomic, strong) VideoPlayerView *playerView2;
@end

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor blackColor];
        
        self.autoresizesSubviews = true;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _playerView = [[VideoPlayerView alloc] initWithFrame:CGRectZero];
        _playerView.translatesAutoresizingMaskIntoConstraints = false;
        _playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _playerView.shouldAutoplay = true;
//        [_playerView loadAsset:@"pinterest.mp4"];
        [self addSubview:_playerView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)durationCompleteEventWithSender:(id)sender forEvent:(UIEvent*)event {
//    [_playerView removeFromSuperview];
//
//    _playerView2 = [[VideoPlayerView alloc] initWithFrame:self.bounds];
//    _playerView2.translatesAutoresizingMaskIntoConstraints = false;
//    _playerView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _playerView2.shouldAutoplay = true;
//    [_playerView2 loadAsset:@"taylor.mov"];
//    [self addSubview:_playerView2];
    
    self.currentItem = [self.viewModel nextContentWithContent:self.currentItem];
    
    [self.playerView removeFromSuperview];
    self.playerView = nil;
    
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    
    if (self.currentItem.isVideo) {
        self.playerView = [[VideoPlayerView alloc] initWithFrame:CGRectZero];
        self.playerView.translatesAutoresizingMaskIntoConstraints = false;
        self.playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.playerView.shouldAutoplay = true;
        [self addSubview:self.playerView];
        
        [self.playerView loadAsset:self.currentItem.url];
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.0];
        
        self.playerView.frame = self.bounds;
        
        [CATransaction commit];
        
    } else {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.translatesAutoresizingMaskIntoConstraints = false;
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        
        UIImage *image = [UIImage imageWithContentsOfFile:self.currentItem.url.path];
        [self.imageView setImage:image];
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.0];
        
        self.imageView.frame = self.bounds;
        
        [CATransaction commit];
        
        
        __weak ContentView *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf durationCompleteEventWithSender:nil forEvent:nil];
        });
    }

    
}

- (void)startPlayingContent {
    if (!self.isPlaying) {
        self.currentItem = [self.viewModel nextContentWithContent:nil];
        self.isPlaying = true;
        if (self.currentItem.isVideo) {
            [self.imageView removeFromSuperview];
            self.imageView = nil;
            
            [self.playerView loadAsset:self.currentItem.url];
            
        } else {
            [self.playerView removeFromSuperview];
            self.playerView = nil;
            
            UIImage *image = [UIImage imageWithContentsOfFile:self.currentItem.url.path];
            
            [self.imageView setImage:image];
            
            __weak ContentView *weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf durationCompleteEventWithSender:nil forEvent:nil];
            });
        }
    }
}

@end
