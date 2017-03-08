//
//  UIBezierPath+OffsetPosition.h
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cgfutil.h"

@interface UIBezierPath (OffsetPosition)

- (UIBezierPath*)bezierPathByTransformingWithOffset:(CGPoint)offset;

@end