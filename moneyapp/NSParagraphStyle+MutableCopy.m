//
//  NSParagraphStyle+MutableCopy.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "NSParagraphStyle+MutableCopy.h"

@implementation NSParagraphStyle (MutableCopy)

- (NSMutableParagraphStyle*)mutableParagraphStyle {
    NSParagraphStyle *paragraphStyle = self;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = paragraphStyle.lineSpacing;
    style.paragraphSpacing = paragraphStyle.paragraphSpacing;
    style.alignment = paragraphStyle.alignment;
    style.firstLineHeadIndent = paragraphStyle.firstLineHeadIndent;
    style.headIndent = paragraphStyle.headIndent;
    style.tailIndent = paragraphStyle.tailIndent;
    style.lineBreakMode = paragraphStyle.lineBreakMode;
    style.minimumLineHeight = paragraphStyle.minimumLineHeight;
    style.maximumLineHeight = paragraphStyle.maximumLineHeight;
    style.baseWritingDirection = paragraphStyle.baseWritingDirection;
    style.lineHeightMultiple = paragraphStyle.lineHeightMultiple;
    style.paragraphSpacingBefore = paragraphStyle.paragraphSpacingBefore;
    style.hyphenationFactor = paragraphStyle.hyphenationFactor;
    style.tabStops = paragraphStyle.tabStops;
    style.defaultTabInterval = paragraphStyle.defaultTabInterval;
    return style;
}

@end
