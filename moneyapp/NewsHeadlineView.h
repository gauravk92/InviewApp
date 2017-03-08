//
//  NewsHeadlineView.h
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlBarModel.h"

@interface NewsHeadlineView : UIView

@property (nonatomic, weak) ControlBarModel *viewModel;

+ (BOOL)validHeadline:(NSString*)text;

- (void)startAnimatingHeadlines;


@end
