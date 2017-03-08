//
//  cgfutil.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "cgfutil.h"

inline CGFLOAT_TYPE cgffloor(CGFLOAT_TYPE num) {
#if CGFLOAT_IS_DOUBLE
    return floor(num);
#else
    return floorf(num);
#endif
}

inline CGFLOAT_TYPE cgfceil(CGFLOAT_TYPE num) {
#if CGFLOAT_IS_DOUBLE
    return ceil(num);
#else
    return ceilf(num);
#endif
}

inline CGFLOAT_TYPE cgfround(CGFLOAT_TYPE num) {
#if CGFLOAT_IS_DOUBLE
    return round(num);
#else
    return roundf(num);
#endif
}

inline CGFLOAT_TYPE cgfabs(CGFLOAT_TYPE num) {
#if CGFLOAT_IS_DOUBLE
    return fabs(num);
#else
    return fabsf(num);
#endif
}

inline NSNumber * cgfNumberWithCGFloat(CGFLOAT_TYPE num) {
#if CGFLOAT_IS_DOUBLE
    return [NSNumber numberWithDouble:num];
#else
    return [NSNumber numberWithFloat:num];
#endif
}

inline CGFLOAT_TYPE cgfCGFloatWithNumber(NSNumber *number) {
#if CGFLOAT_IS_DOUBLE
    return [number doubleValue];
#else
    return [number floatValue];
#endif
}

inline CGRect CGRectAlign(CGRect rect) {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale == 2) {
        return CGRectMake(cgffloor(rect.origin.x * scale) / scale, cgffloor(rect.origin.y * scale) / scale, cgfceil(rect.size.width * scale) / scale, cgfceil(rect.size.height * scale) / scale);
    } else {
        return CGRectMake(cgffloor(rect.origin.x), cgffloor(rect.origin.y), cgfceil(rect.size.width), cgfceil(rect.size.height));
    }
}

inline CGRect CGRectRound(CGRect rect) {
    return CGRectMake(cgfround(rect.origin.x), cgfround(rect.origin.y), cgfround(rect.size.width), cgfround(rect.size.height));
}

inline CGPoint CGPointAlign(CGPoint point) {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale == 2) {
        return CGPointMake(cgffloor(point.x * scale) / scale, cgffloor(point.y * scale) / scale);
    } else {
        return CGPointMake(cgffloor(point.x), cgffloor(point.y));
    }
}