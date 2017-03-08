//
//  NSAttributedString+UIBezierPath.h
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "cgfutil.h"

@interface NSAttributedString (UIBezierPath)

- (UIBezierPath*)bezierPath;
- (UIBezierPath*)bezierPathWithMultilineFittingSize:(CGSize)maxSize;
- (NSAttributedString*)attributedStringFittingSize:(CGSize)bounds;
- (NSAttributedString*)attributedStringFittingSize:(CGSize)bounds drawingOptions:(NSStringDrawingOptions)opts;
@end
