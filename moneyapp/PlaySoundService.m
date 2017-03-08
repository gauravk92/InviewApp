//
//  PlaySoundService.m
//  Money
//
//  Created by Gaurav Khanna on 7/31/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "PlaySoundService.h"

@implementation PlaySoundService

- (instancetype)init {
    if ((self = [super init])) {
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Satisfying Click_01" ofType:@"aiff"];
//        CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
//        AudioServicesCreateSystemSoundID(url, &clickSound);
//        
//        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"beep-shinymetal" ofType:@"aif"];
//        CFURLRef url2 = (__bridge CFURLRef)[NSURL fileURLWithPath:path2];
//        AudioServicesCreateSystemSoundID(url2, &beepShinyMetal);
//        
//        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"tap-crisp" ofType:@"aif"];
//        CFURLRef url3 = (__bridge CFURLRef)[NSURL fileURLWithPath:path3];
//        AudioServicesCreateSystemSoundID(url3, &tapCrisp);
        
        // need to load and play "silent" sound clip first due to a bug
        NSString *deadpath = [[NSBundle mainBundle] pathForResource:@"Dead Air Sound" ofType:@"aiff"];
        CFURLRef deadurl = (__bridge CFURLRef)[NSURL fileURLWithPath:deadpath];
        AudioServicesCreateSystemSoundID(deadurl, &deadAirSound);
        AudioServicesPlaySystemSound(deadAirSound);
        
        // setup low latency audio session: http://stackoverflow.com/a/35245064
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error;
        @try {
            [session setPreferredIOBufferDuration:0.015 error:&error];
            // TODO: verify preferred IO Buffer duration was set to a low value
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
            NSLog(@"%@", error);
        }
        
        // subscribe for media daemon restarts: Google: "AVAudioSession Configuring the Audio Session"
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionDidRestart:) name:AVAudioSessionMediaServicesWereResetNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionDidRestart:) name:AVAudioSessionMediaServicesWereLostNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionDidRestart:) name:AVAudioSessionSilenceSecondaryAudioHintNotification object: nil];
        
        // TODO: handle possible interruptions
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionDidInterrupt:) name:AVAudioSessionInterruptionNotification object: nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionDidInterrupt:) name:AVAudioSessionRouteChangeNotification object: nil];
        
        
        NSURL *beepSoundURL = [[NSBundle mainBundle] URLForResource:@"beep-shinymetal" withExtension:@"caf"];
        NSError *audioLoadError;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:beepSoundURL error:&audioLoadError];
        [self.player prepareToPlay];
        [self.player setDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AudioServicesDisposeSystemSoundID(deadAirSound);
    //    AudioServicesDisposeSystemSoundID(clickSound);
}

- (void)playControlBarTapSound {
    // use AVAudioPlayer so it respects the volume
    [self.player play];
}

- (void)playSystemSecurityAlertSound {
    // TODO: use system sound so it plays regardless of volume
//    AudioServicesPlaySystemSound(alertSound);
}


- (void)audioSessionDidRestart:(NSNotification*)notif {
    NSLog(@"notif");
    // TODO: reset the IOBufferDuration if it's not low enough
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error;
        @try {
            [session setPreferredIOBufferDuration:0.015 error:&error];
            // TODO: verify preferred IO Buffer duration was set to a low value
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
            NSLog(@"%@", error);
        }
    });
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)playedPlayer successfully:(BOOL)flag {
//    NSLog(@"Done playing %@", flag ? @"with success" : @"with failure" );
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
//    NSLog(@"Error while decoding: %@", [error localizedDescription] );
}

@end
