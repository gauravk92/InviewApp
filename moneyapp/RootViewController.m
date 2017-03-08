//
//  RootViewController.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "RootViewController.h"
#import "ControlBarController.h"
#import "ContentViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) ControlBarController *controlBarController;
@property (nonatomic, strong) ContentViewController *contentViewController;

@end

@implementation RootViewController

- (BOOL)prefersStatusBarHidden {
    return true;
}

- (void)loadView {
    self.view = self.rootView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
        _rootView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _controlBarController = [[ControlBarController alloc] initWithNibName:nil bundle: nil];
        [self.view addSubview:_controlBarController.view];
        [self addChildViewController:_controlBarController];
        [_controlBarController didMoveToParentViewController:self];
    
        _contentViewController = [[ContentViewController alloc] initWithNibName:nil bundle:nil];
        [self.view addSubview:_contentViewController.view];
        [self addChildViewController:_contentViewController];
        [_contentViewController didMoveToParentViewController:self];
    }
    return self;
}

- (void)setup {
    [self.controlBarController setup];
    [self.contentViewController setup];
}

- (void)teardown {
    [self.controlBarController teardown];
    [self.contentViewController teardown];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.contentViewController.view.frame = CGRectMake(0, 0, 1024, 564);
    [self.view bringSubviewToFront:self.contentViewController.view];
}

@end
