//
//  UIBezierPath+OffsetPosition.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "UIBezierPath+OffsetPosition.h"

@implementation UIBezierPath (OffsetPosition)

- (UIBezierPath*)bezierPathByTransformingWithOffset:(CGPoint)offset {
    CGRect boundBox = CGPathGetPathBoundingBox(self.CGPath);
    CGPoint boundAdjust = boundBox.origin;
    boundBox.origin.x += offset.x;
    boundBox.origin.y += offset.y;
    boundBox = CGRectAlign(boundBox);
    
    CGPoint boundMove = CGPointAlign(CGPointMake(-boundAdjust.x + boundBox.origin.x, -boundAdjust.y + boundBox.origin.y));
    CGAffineTransform moveTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, boundMove.x, boundMove.y);
    CGPathRef movePath = CGPathCreateCopyByTransformingPath(self.CGPath, &moveTransform);
    UIBezierPath *transformedPath = [UIBezierPath bezierPath];
    transformedPath.flatness = 0.0;
    transformedPath.CGPath = movePath;
    
    CGPathRelease(movePath);
    
    return transformedPath;
}

@end
