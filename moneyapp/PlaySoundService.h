//
//  PlaySoundService.h
//  Money
//
//  Created by Gaurav Khanna on 7/31/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaySoundService : NSObject <AVAudioPlayerDelegate> {
    SystemSoundID deadAirSound;
    SystemSoundID clickSound;
    SystemSoundID beepShinyMetal;
    SystemSoundID tapCrisp;
}

@property (nonatomic, strong) AVAudioPlayer *player;

- (void)playControlBarTapSound;

@end
