//
//  ControlBarController.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ControlBarController.h"
#import "SingleTapGestureRecognizer.h"
#import "ControlBarView.h"
#import "ControlBarModel.h"
#import "BareBonesView.h"
#import "BatteryService.h"
#import "WeatherService.h"
#import "NewsHeadlineView.h"

@import Firebase;

@interface ControlBarController () <UIGestureRecognizerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) SingleTapGestureRecognizer *audioPlusTap;
@property (nonatomic, strong) SingleTapGestureRecognizer *audioMinusTap;
@property (nonatomic, strong) SingleTapGestureRecognizer *brightnessUpTap;
@property (nonatomic, strong) SingleTapGestureRecognizer *brightnessDownTap;

@property (nonatomic, strong) NSTimer *updateTimeTimer;
@property (nonatomic, strong) NSDateFormatter *timeStringFormatter;
@property (nonatomic, strong) NSDateFormatter *dateStringFormatter;

@property (nonatomic, strong) PlaySoundService *playSoundService;
@property (nonatomic, strong) ControlBarView *controlBarView;
@property (nonatomic, strong) ControlBarModel *viewModel;

@property (nonatomic, strong) FIRDatabaseReference *headlinesRef;

@property (nonatomic, strong) FIRDatabaseReference *tipRef;
@property (nonatomic, strong) FIRDatabaseQuery *driverTipQuery;

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSTimer *locationTimer;
@property (nonatomic, strong) WeatherService *weatherService;

@end

@implementation ControlBarController

- (void)loadView {
    self.view = self.controlBarView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
        _viewModel = [ControlBarModel new];
        _viewModel.delegate = self;
        
        _controlBarView = [[ControlBarView alloc] initWithFrame:CGRectZero];
        _playSoundService = [PlaySoundService new];
        
        _controlBarView.newsHeadlineView.viewModel = _viewModel;
        
        _audioPlusTap = [[SingleTapGestureRecognizer alloc] initWithTarget:self action:@selector(audioPlusTapGesture:)];
        _audioPlusTap.delegate = self;
        [self.view addGestureRecognizer:_audioPlusTap];
        
        _audioMinusTap = [[SingleTapGestureRecognizer alloc] initWithTarget:self action:@selector(audioMinusTapGesture:)];
        _audioMinusTap.delegate = self;
        [self.view addGestureRecognizer:_audioMinusTap];
        
        _brightnessUpTap = [[SingleTapGestureRecognizer alloc] initWithTarget:self action:@selector(brightnessUpTapGesture:)];
        _brightnessUpTap.delegate = self;
        [self.view addGestureRecognizer:_brightnessUpTap];
        
        _brightnessDownTap = [[SingleTapGestureRecognizer alloc] initWithTarget:self action:@selector(brightnessDownTapGesture:)];
        _brightnessDownTap.delegate = self;
        [self.view addGestureRecognizer:_brightnessDownTap];
        
        _timeStringFormatter = [NSDateFormatter new];
        _dateStringFormatter = [NSDateFormatter new];
        _timeStringFormatter.dateFormat = @"h:mm";
        _dateStringFormatter.dateFormat = @"MMM d";
        
        _weatherService = [[WeatherService alloc] init];
        _weatherService.delegate = self;
    
        _manager = [CLLocationManager new];
        _manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _manager.delegate = self;
        _manager.distanceFilter = 20;
        _manager.activityType = CLActivityTypeAutomotiveNavigation;
        _manager.pausesLocationUpdatesAutomatically = false;
        [_manager requestAlwaysAuthorization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIScreen mainScreen].wantsSoftwareDimming = true;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view setNeedsDisplay];
    [self.manager startUpdatingLocation];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.controlBarView.newsHeadlineView animateNewHeadline];
//        
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //        [self.controlBarView.newsHeadlineView animateNewHeadline];
//        [self.controlBarView.newsHeadlineView animateFadeHeadline:@"fade"];
//    });
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //        [self.controlBarView.newsHeadlineView animateNewHeadline];
//        [self.controlBarView.newsHeadlineView animateFadeHeadline:@"fade2"];
//    });
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //        [self.controlBarView.newsHeadlineView animateNewHeadline];
//        [self.controlBarView.newsHeadlineView animateFadeHeadline:@"fade3"];
//    });
}

- (void)updateLocationTimerFired:(NSTimer*)timer {
    if (self.view.window) {
        [self.manager startUpdatingLocation];
    } else {
        [self.manager stopUpdatingLocation];
    }
}

- (void)setup {
    
    [UIApplication sharedApplication].idleTimerDisabled = true;
    
    self.updateTimeTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateTimeTimerFired:) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.updateTimeTimer forMode:NSRunLoopCommonModes];
    
    self.locationTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(updateLocationTimerFired:) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.locationTimer forMode:NSRunLoopCommonModes];
    
    [self.manager startUpdatingLocation];
//    NSLog(@"location services enabled %i", self.manager.locationServicesEnabled);
    [self.weatherService setup];
    
    __weak ControlBarController *weakSelf = self;
    
    self.headlinesRef = [[FIRDatabase database] referenceWithPath:@"/news/headlines"];
    
    [self.headlinesRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:1];
        if ([snapshot.value isKindOfClass:[NSArray class]]) {
            NSArray *val = (NSArray*)snapshot.value;
            for (NSDictionary *obj in val) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *headline = [obj objectForKey:@"headline"];
                    NSString *site = [obj objectForKey:@"site"];
                    if (headline && site) {
                        if ([NewsHeadlineView validHeadline:headline]) {
//                            NSLog(@"headline: %@", headline);
                            [data addObject:obj];
                        } else {
//                            NSLog(@"discarded: %@", headline);
                        }
                    }
                } else {
                    NSLog(@"ERROR: Expected news headline of dictionary type");
                }
            }
            //NSLog(@"data: %@", data);
            [weakSelf.viewModel updateHeadlines:data];
        } else {
            NSLog(@"ERROR: Expected headline snapshot of array");
        }
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    
    self.tipRef = [[FIRDatabase database] referenceWithPath:@"/userevents/8adsfu23adf9/driverTipInfo"];
    
    self.driverTipQuery = [self.tipRef queryLimitedToLast:1];
    
    [self.driverTipQuery observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if (snapshot.value == [NSNull null]) {
            DLog(@"ERROR: firebase snapshot returned null");
        }
        
        NSLog(@"snapshot: %@", snapshot.value);
        NSLog(@"class: %@", [snapshot.value class]);
        if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *val = (NSDictionary*)snapshot.value;
            for (id key in val) {
                NSDictionary *obj = [val objectForKey:key];
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *paypal = [obj objectForKey:@"paypal"];
                    NSString *venmo = [obj objectForKey:@"venmo"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ControlBarController *strongSelf = weakSelf;
                        if (paypal) {
                            [strongSelf.viewModel updatePaypalString:paypal];
                        }
                        if (venmo) {
                            [strongSelf.viewModel updateVenmoString:venmo];
                        }
                        
                    });
                    
                    
                } else {
                    NSLog(@"ERROR: Expected driverTipInfo of dictionary type");
                }
            }
        } else {
            NSLog(@"ERROR: Expected dictionary type");
        }
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    self.controlBarView.weatherString = @"-°";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ControlBarController *strongSelf = weakSelf;
        [strongSelf.controlBarView setNeedsDisplayInRect:strongSelf.controlBarView.weatherRect];
    
        [strongSelf.viewModel setup];
    });
}

- (void)teardown {
    [self.manager stopUpdatingLocation];
    [self.weatherService teardown];
    
    [self.updateTimeTimer invalidate];
    self.updateTimeTimer = nil;
    
    [self.locationTimer invalidate];
    self.locationTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.driverTipQuery removeAllObservers];
    self.driverTipQuery = nil;
    [self.tipRef removeAllObservers];
    self.tipRef = nil;
    [self.headlinesRef removeAllObservers];
    self.headlinesRef = nil;
}

- (void)dealloc {
    [self teardown];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    for (CLLocation *loc in locations) {
        if (CLLocationCoordinate2DIsValid(loc.coordinate)) {
            [self.viewModel updateLocation:loc];
//            NSLog(@"updated loc: %@", loc);
            return;
        }
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"pausing location updates");
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"resuming location updates");
}

- (void)viewModelChangedHeadlines {
    [self.controlBarView.newsHeadlineView startAnimatingHeadlines];
}

- (void)viewModelChangedLocation:(CLLocation*)location {
    if (location && CLLocationCoordinate2DIsValid(location.coordinate)) {
        self.weatherService.location = location;
    }
}

- (void)viewModelChangedPaypalString:(NSString*)string {
    if (string) {
        self.controlBarView.paypalString = string;
        if (self.view.window) {
            [self.controlBarView setNeedsDisplayInRect:self.controlBarView.paypalRect];
        }
    }
}

- (void)viewModelChangedVenmoString:(NSString*)string {
    if (string) {
        self.controlBarView.venmoString = string;
        if (self.view.window) {
            [self.controlBarView setNeedsDisplayInRect:self.controlBarView.venmoRect];
        }
    }
}

- (void)weatherServiceUpdatedWeatherString:(NSString*)string {
    [self.viewModel updateWeatherString:string];
}

- (void)viewModelChangedWeatherString:(NSString*)string {
    if (string) {
        self.controlBarView.weatherString = string;
        if (self.view.window) {
            [self.controlBarView setNeedsDisplayInRect:self.controlBarView.weatherRect];
        }
    }
}

- (void)viewModelChangedVolume:(float)volume {
    [self.controlBarView setVolume:volume];
}

- (void)viewModelChangedBrightness:(CGFloat)brightness {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIScreen mainScreen].brightness = brightness;
    });
}

- (void)updateTimeTimerFired:(NSTimer*)timer {
    NSDateFormatter *timeFormatter = self.timeStringFormatter;
    NSDateFormatter *dateFormatter = self.dateStringFormatter;
    NSString *timeString = self.controlBarView.timeString;
    NSString *dateString = self.controlBarView.dateString;
    
    __weak ControlBarController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDate *currentDate = [NSDate new];
        NSString *newTime = [timeFormatter stringFromDate:currentDate];
        NSString *newDate = [dateFormatter stringFromDate:currentDate];
        
        bool willUpdateTime = (![timeString isEqualToString:newTime]);
        bool willUpdateDate = (![dateString isEqualToString:newDate]);
        
        if (willUpdateTime || willUpdateDate) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ControlBarController *strongSelf = weakSelf;
                if (willUpdateTime) {
                    strongSelf.controlBarView.timeString = newTime;
                    [strongSelf.controlBarView setNeedsDisplayInRect:strongSelf.controlBarView.timeRect];
                }
                if (willUpdateDate) {
                    strongSelf.controlBarView.dateString = newDate;
                    [strongSelf.controlBarView setNeedsDisplayInRect:strongSelf.controlBarView.dateRect];
                }
            });
        }
    });
    
}

- (void)audioPlusTapGesture:(SingleTapGestureRecognizer*)gc {
    if (gc.state == UIGestureRecognizerStateBegan) {
        self.controlBarView.highlightControlState = BareBonesViewStateHighlightAudioControlPlus;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.audioControlPlusRect];
        
        [self.playSoundService playControlBarTapSound];
        
        [self.viewModel volumeUp];
    } else if (gc.state == UIGestureRecognizerStateCancelled || gc.state == UIGestureRecognizerStateFailed || gc.state == UIGestureRecognizerStateRecognized) {
        self.controlBarView.highlightControlState = BareBonesViewStateDefault;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.audioControlPlusRect];
    }
}

- (void)audioMinusTapGesture:(SingleTapGestureRecognizer*)gc {
    if (gc.state == UIGestureRecognizerStateBegan) {
        self.controlBarView.highlightControlState = BareBonesViewStateHighlightAudioControlMinus;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.audioControlMinusRect];
        
        [self.playSoundService playControlBarTapSound];
        
        [self.viewModel volumeDown];
    } else if (gc.state == UIGestureRecognizerStateCancelled || gc.state == UIGestureRecognizerStateFailed || gc.state == UIGestureRecognizerStateRecognized) {
        self.controlBarView.highlightControlState = BareBonesViewStateDefault;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.audioControlMinusRect];
    }
}

- (void)brightnessUpTapGesture:(SingleTapGestureRecognizer*)gc {
    if (gc.state == UIGestureRecognizerStateBegan) {
        self.controlBarView.highlightControlState = BareBonesViewStateHighlightBrightnessControlUp;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.brightnessUpRect];
        
        [self.playSoundService playControlBarTapSound];
        
        [self.viewModel brightnessUp];
    } else if (gc.state == UIGestureRecognizerStateCancelled || gc.state == UIGestureRecognizerStateFailed || gc.state == UIGestureRecognizerStateRecognized) {
        self.controlBarView.highlightControlState = BareBonesViewStateDefault;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.brightnessUpRect];
    }
}

- (void)brightnessDownTapGesture:(SingleTapGestureRecognizer*)gc {
    if (gc.state == UIGestureRecognizerStateBegan) {
        self.controlBarView.highlightControlState = BareBonesViewStateHighlightBrightnessControlDown;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.brightnessDownRect];
        
        [self.playSoundService playControlBarTapSound];
        
        [self.viewModel brightnessDown];
    } else if (gc.state == UIGestureRecognizerStateCancelled || gc.state == UIGestureRecognizerStateFailed || gc.state == UIGestureRecognizerStateRecognized) {
        self.controlBarView.highlightControlState = BareBonesViewStateDefault;
        [self.controlBarView setNeedsDisplayInRect:self.controlBarView.brightnessDownRect];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gc shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.view];
    if (gc == self.audioPlusTap) {
        return CGRectContainsPoint(self.controlBarView.audioControlPlusRect, point);
    } else if (gc == self.audioMinusTap){
        return CGRectContainsPoint(self.controlBarView.audioControlMinusRect, point);
    }  else if (gc == self.brightnessUpTap){
        return CGRectContainsPoint(self.controlBarView.brightnessUpRect, point);
    }else if (gc == self.brightnessDownTap){
        return CGRectContainsPoint(self.controlBarView.brightnessDownRect, point);
    }
    return true;
}

@end
