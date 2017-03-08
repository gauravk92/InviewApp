//
//  NSAttributedString+UIBezierPath.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "NSAttributedString+UIBezierPath.h"

@implementation NSAttributedString (UIBezierPath)

- (UIBezierPath*)bezierPath {
    
    NSAttributedString *attributedString = self;
    
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    CGMutablePathRef letters = CGPathCreateMutable();

    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);

            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformTranslate(CGAffineTransformIdentity, position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }

    CGRect boundBox = CGPathGetPathBoundingBox(letters);

    CGPoint pathCenterPoint = CGPointMake(CGRectGetMidX(boundBox), CGRectGetMidY(boundBox));

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGAffineTransform translateTransform = CGAffineTransformTranslate(scaleTransform, -pathCenterPoint.x, -pathCenterPoint.y);
    CGAffineTransform translateBackTransform = CGAffineTransformMakeTranslation(pathCenterPoint.x, pathCenterPoint.y);

    CGPathRef centeredAndScaled = CGPathCreateCopyByTransformingPath(letters, &translateTransform);
    CGPathRef path = CGPathCreateCopyByTransformingPath(centeredAndScaled, &translateBackTransform);

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.flatness = 0.0;
    bezierPath.CGPath = path;

    CGPathRelease(centeredAndScaled);
    CGPathRelease(path);
    CGPathRelease(letters);
    CFRelease(line);

    return bezierPath;
}

- (UIBezierPath*)bezierPathWithMultilineFittingSize:(CGSize)maxSize {
    NSAttributedString *attrString = self;
    CGFloat maxWidth = maxSize.width;
    CGFloat maxHeight = maxSize.height;
    
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CGRect bounds = CGRectMake(0, 0, maxWidth, maxHeight);
    
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attrString));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    CGPoint *points = malloc(sizeof(CGPoint) * CFArrayGetCount(lines));
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    
    NSInteger numLines = CFArrayGetCount(lines);
    // for each LINE
    for (CFIndex lineIndex = 0; lineIndex < numLines; lineIndex++)
    {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CFRange r = CTLineGetStringRange(lineRef);
        
        NSParagraphStyle *paragraphStyle = [attrString attribute:NSParagraphStyleAttributeName atIndex:r.location effectiveRange:NULL];
        NSTextAlignment alignment = paragraphStyle.alignment;
        
        
        CGFloat flushFactor = 0.0;
        if (alignment == NSTextAlignmentLeft) {
            flushFactor = 0.0;
        } else if (alignment == NSTextAlignmentCenter) {
            flushFactor = 0.5;
        } else if (alignment == NSTextAlignmentRight) {
            flushFactor = 1.0;
        }
        
        
        
        CGFloat penOffset = CTLineGetPenOffsetForFlush(lineRef, flushFactor, maxWidth);
        
        // create a new justified line if the alignment is justified
        if (alignment == NSTextAlignmentJustified) {
            lineRef = CTLineCreateJustifiedLine(lineRef, 1.0, maxWidth);
            penOffset = 0;
        }
        
        CGFloat lineOffset = numLines == 1 ? 0 : maxHeight - points[lineIndex].y;
        
        CFArrayRef runArray = CTLineGetGlyphRuns(lineRef);
        
        // for each RUN
        for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
        {
            // Get FONT for this run
            CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
            
            // for each GLYPH in run
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
            {
                // get Glyph & Glyph-data
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                
                position.y -= lineOffset;
                position.x += penOffset;
                
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
        
        // if the text is justified then release the new justified line we created.
        if (alignment == NSTextAlignmentJustified) {
            CFRelease(lineRef);
        }
    }
    
    free(points);
    
    CGPathRelease(pathRef);
    CFRelease(frame);
    CFRelease(framesetter);
    
    CGRect boundBox = CGPathGetPathBoundingBox(letters);
    
    CGPoint pathCenterPoint = CGPointMake(CGRectGetMidX(boundBox), CGRectGetMidY(boundBox));
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGAffineTransform translateTransform = CGAffineTransformTranslate(scaleTransform, -pathCenterPoint.x, -pathCenterPoint.y);
    CGAffineTransform translateBackTransform = CGAffineTransformMakeTranslation(pathCenterPoint.x, -pathCenterPoint.y);
    
    CGPathRef centeredAndScaled = CGPathCreateCopyByTransformingPath(letters, &translateTransform);
    CGPathRef path = CGPathCreateCopyByTransformingPath(centeredAndScaled, &translateBackTransform);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.flatness = 0.0;
    bezierPath.CGPath = path;
    
    CGPathRelease(centeredAndScaled);
    CGPathRelease(path);
    CGPathRelease(letters);
    
    return bezierPath;
}

- (NSAttributedString*)attributedStringFittingSize:(CGSize)bounds {
    return [self attributedStringFittingSize:bounds drawingOptions:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin];
}

- (NSAttributedString*)attributedStringFittingSize:(CGSize)bounds drawingOptions:(NSStringDrawingOptions)opts {
    NSString *string = self.string;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithCapacity:1];
    
    [self enumerateAttributesInRange:NSMakeRange(0, self.string.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attr, NSRange range, BOOL * _Nonnull stop) {
        [attrs addEntriesFromDictionary:attr];
    }];
    CGFloat maxWidth = bounds.width;

    UIFont *font = attrs[NSFontAttributeName];
    CGFloat maxFontSize = font.pointSize;
    CGFloat currentFontSize = maxFontSize;

    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:attrs];

    while (currentFontSize > maxFontSize - 10) {

        UIFont *currentFont = [UIFont fontWithName:font.fontName size:currentFontSize];
        dict[NSFontAttributeName] = currentFont;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:dict];
        CGRect boundRect = [attrString boundingRectWithSize:bounds options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        if (boundRect.size.width <= maxWidth) {
            return attrString;
        }
        currentFontSize -= 0.01;
    }
    return nil;
}

@end
