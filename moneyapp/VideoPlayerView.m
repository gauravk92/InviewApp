//
//  VideoPlayerView.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "VideoPlayerView.h"


NSString *VideoPlayerViewItemKeyStatus = @"status";

@interface VideoPlayerView ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, assign, readwrite) BOOL readyToPlay;
@property (nonatomic, assign, readwrite) BOOL playingEnded;
@property (nonatomic, strong, readwrite) NSURL *model;

@end

@implementation VideoPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player {
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.layer;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    playerLayer.player = player;
}

- (void)loadAsset:(NSURL*)aURL {
    self.readyToPlay = NO;
//    self.shouldAutoplay = NO;
    self.playingEnded = NO;
    self.model = aURL;
    
    [self.playerItem removeObserver:self forKeyPath:VideoPlayerViewItemKeyStatus context:NULL];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.model options:nil];
    NSString *tracksKey = @"tracks";
    
    __weak VideoPlayerView *weakSelf = self;
    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            VideoPlayerView *strongSelf = weakSelf;
            NSError *error;
            AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
            
            if (status == AVKeyValueStatusLoaded) {
                strongSelf.playerItem = [AVPlayerItem playerItemWithAsset:asset];
                // ensure that this is done before the playerItem is associated with the player
                [strongSelf.playerItem addObserver:strongSelf forKeyPath:VideoPlayerViewItemKeyStatus options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
                
                [[NSNotificationCenter defaultCenter] addObserver:strongSelf
                                                         selector:@selector(playerItemDidReachEnd:)
                                                             name:AVPlayerItemDidPlayToEndTimeNotification
                                                           object:strongSelf.playerItem];
                
                strongSelf.player = [AVPlayer playerWithPlayerItem:strongSelf.playerItem];
                
                [strongSelf setPlayer:strongSelf.player];
            }
            else {
                // You should deal with the error appropriately.
                NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
            }
            //
            //                            [[NSNotificationCenter defaultCenter]
            //                             addObserver:self
            //                             selector:@selector(playerItemDidReachEnd:)
            //                             name:AVPlayerItemDidPlayToEndTimeNotification
            //                             object:[self.player currentItem]];
            
        });
    }];
}

- (void)rewind {
    [self.player seekToTime:kCMTimeZero];
    self.playingEnded = NO;
    self.shouldAutoplay = NO;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    self.playingEnded = YES;
    UIEvent *event = [[UIEvent alloc] init];
    [[UIApplication sharedApplication] sendAction:@selector(durationCompleteEventWithSender:forEvent:) to:nil from:self forEvent:event];
}

- (void)play {
    __weak VideoPlayerView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        VideoPlayerView *strongSelf = weakSelf;
        
        if (strongSelf.playingEnded) {
            [strongSelf rewind];
        }
        if (strongSelf.readyToPlay) {
            [strongSelf.player play];
        } else {
            strongSelf.shouldAutoplay = YES;
        }
        
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:VideoPlayerViewItemKeyStatus]) {
        if (self.player.status == AVPlayerItemStatusReadyToPlay) {
            self.readyToPlay = YES;
            if (self.shouldAutoplay) {
                [self play];
            }
        } else if (self.player.status == AVPlayerItemStatusFailed) {
            NSLog(@"failure to play error %@", self);
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow == nil) {
        // Will be removed from window, similar to -viewDidUnload.
        // Unsubscribe from any notifications here.
        
        [self.playerItem removeObserver:self forKeyPath:VideoPlayerViewItemKeyStatus context:NULL];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
