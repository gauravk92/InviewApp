//
//  ContentView.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewModel.h"

@interface ContentView : UIView

@property (nonatomic, weak) ContentViewModel *viewModel;

- (void)startPlayingContent;

@end
