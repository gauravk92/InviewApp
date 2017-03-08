//
//  ContentViewController.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentView.h"
#import "ContentViewModel.h"

@import Firebase;

@interface ContentViewController ()

@property (nonatomic, strong) ContentViewModel *viewModel;
@property (nonatomic, strong) ContentView *contentView;

@property (nonatomic, strong) FIRDatabaseReference *adsRef;
@property (nonatomic, strong) NSArray *currentAds;
@property (nonatomic, strong) FIRDatabaseReference *uploadsRef;
@property (nonatomic, strong) NSArray *currentUploads;
@end

@implementation ContentViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
        _viewModel = [ContentViewModel new];
        _viewModel.delegate = self;
        
        _contentView = [[ContentView alloc] initWithFrame:CGRectZero];
        _contentView.viewModel = _viewModel;
    }
    return self;
}

- (void)loadView {
    self.view = self.contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    __weak ContentViewController *weakSelf = self;
    
    self.adsRef = [[FIRDatabase database] referenceWithPath:@"/ads"];
    
    [self.adsRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if ([snapshot.value isKindOfClass:[NSArray class]]) {
            NSArray *val = (NSArray*)snapshot.value;
            
            ContentViewController *strongSelf = weakSelf;
            strongSelf.currentAds = val;
            [strongSelf dbUpdatedContent];
            
        } else {
            NSLog(@"ERROR: Expected headline snapshot of array");
        }
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    self.uploadsRef = [[FIRDatabase database] referenceWithPath:@"/userevents/8adsfu23adf9/uploads/current/"];
    
    [self.uploadsRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *val = (NSDictionary*)snapshot.value;
            ContentViewController *strongSelf = weakSelf;
            
            strongSelf.currentUploads = val.allValues;
            [strongSelf dbUpdatedContent];
            
        } else {
            NSLog(@"ERROR: Expected headline snapshot of array");
        }
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}

- (void)dbUpdatedContent {
    NSUInteger adsCount = self.currentAds.count;
    NSUInteger currentCount = self.currentUploads.count;
    if (self.currentAds && adsCount > 0 && self.currentUploads && currentCount > 0) {
        NSUInteger capacity = 0;
        capacity += adsCount + currentCount;
        NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:capacity];
        [data addObjectsFromArray:self.currentUploads];
        [data addObjectsFromArray:self.currentAds];
        [data shuffle];
        [self.viewModel updateContent:data];
    }
}

- (void)viewModelChangedContent:(NSArray*)array {
    [self.contentView startPlayingContent];
}

- (void)teardown {
    [self.adsRef removeAllObservers];
    self.adsRef = nil;
    
    [self.uploadsRef removeAllObservers];
    self.uploadsRef = nil;
}


@end
