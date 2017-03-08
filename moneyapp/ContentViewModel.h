//
//  ContentViewModel.h
//  moneyapp
//
//  Created by Gaurav Khanna on 9/22/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentViewController.h"

@interface IAContentItem : NSObject

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, assign) BOOL isVideo;

@end

@interface ContentViewModel : NSObject

@property (nonatomic, weak) ContentViewController *delegate;

- (NSUInteger)nextIndexWithContent:(IAContentItem*)dict;
- (IAContentItem*)nextContentWithContent:(IAContentItem *)item;

- (void)updateContent:(NSArray*)array;

@end
