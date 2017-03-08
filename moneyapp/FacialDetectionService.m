//
//  FacialDetectionService.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/23/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "FacialDetectionService.h"

@interface FacialDetectionService ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *captureVideoOutput;
@property (nonatomic, strong) AVCaptureConnection *captureVideoConnection;
@property (nonatomic, strong) NSError *captureError;

@end

@implementation FacialDetectionService

- (instancetype)init {
    if ((self = [super init])) {
        
        
    }
    return self;
}

- (void)setup {
    
    self.captureSession = [AVCaptureSession new];
    self.movieFileOutput = [AVCaptureMovieFileOutput new];
    self.captureVideoOutput = [AVCaptureVideoDataOutput new];
    
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *dev in devices) {
        if ([dev hasMediaType:AVMediaTypeVideo] && dev.position == AVCaptureDevicePositionFront) {
            captureDevice = dev;
        }
    }
    
    if (captureDevice) {
        
        @try {
            NSError *devInputErr;
            AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&devInputErr];
            if (deviceInput) {
                NSError *lockConfigErr;
                if ([captureDevice lockForConfiguration:&lockConfigErr]) {
                    
                    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                        [captureDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
                    }
                    
                    captureDevice.activeVideoMaxFrameDuration = CMTimeMake(1, 30);
                    [captureDevice unlockForConfiguration];
                    
                    
                    
                } else {
                    NSLog(@"ERROR: locking config: %@", lockConfigErr);
                }
                
                if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
                    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
                } else {
                    NSLog(@"ERROR: Unable to set session preset");
                }
                          
                if ([self.captureSession canAddInput:deviceInput]) {
                    [self.captureSession addInput:deviceInput];
                } else {
                    NSLog(@"ERROR: Unable to add device input");
                }
                
                self.movieFileOutput.maxRecordedDuration = CMTimeMake(30, 30);
                self.movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024 * 1000;
                self.movieFileOutput.maxRecordedFileSize = 1024 * 1024 * 20;
                
                if ([self.captureSession canAddOutput:self.movieFileOutput]) {
                    [self.captureSession addOutput:self.movieFileOutput];
                } else {
                    NSLog(@"ERROR: Unable to add capture session output");
                }
                
                if ([self.captureSession canAddOutput:self.captureVideoOutput]) {
                    [self.captureSession addOutput:self.captureVideoOutput];
                    
                    self.captureVideoConnection = [self.captureVideoOutput connectionWithMediaType:AVMediaTypeVideo];
                    if ([self.captureVideoConnection isVideoOrientationSupported]) {
                        [self.captureVideoConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
                    } else {
                        NSLog(@"ERROR: could not set video orientation");
                    }
                } else {
                    NSLog(@"ERROR: Could not add video output to capture session");
                }
                
                [self.captureSession commitConfiguration];
                
            } else {
                NSLog(@"ERROR: Unable to get front device: %@", devInputErr);
            }
        } @catch (NSException *exception) {
            NSLog(@"EXCEPTION: %@", exception);
        } @finally {
            
        }
        
    }
    
}

- (void)teardown {
    
}

@end
