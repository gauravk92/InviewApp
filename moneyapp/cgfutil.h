//
//  cgfutil.h
//  Money
//
//  Created by Gaurav Khanna on 7/31/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#ifndef cgfutil_h
#define cgfutil_h

#import <UIKit/UIKit.h>

CGFLOAT_TYPE cgffloor(CGFLOAT_TYPE num);
CGFLOAT_TYPE cgfceil(CGFLOAT_TYPE num);
CGFLOAT_TYPE cgfround(CGFLOAT_TYPE cgfloat);
CGFLOAT_TYPE cgfabs(CGFLOAT_TYPE cgfloat);
NSNumber *cgfNumberWithCGFloat(CGFLOAT_TYPE cgfloat);
CGFLOAT_TYPE cgfCGFloatWithNumber(NSNumber *number);
CGRect CGRectAlign(CGRect rect);
CGRect CGRectRound(CGRect rect);
CGPoint CGPointAlign(CGPoint point);

#endif /* cgfutil_h */
