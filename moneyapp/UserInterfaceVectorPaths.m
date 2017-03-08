//
//  UserInterfaceVectorPaths.m
//  Money
//
//  Created by Gaurav Khanna on 7/29/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "UserInterfaceVectorPaths.h"

@implementation UserInterfaceVectorPaths

+ (UIBezierPath*)audioControlBackground {
    UIBezierPath* bezier7Path = UIBezierPath.bezierPath;
    [bezier7Path moveToPoint: CGPointMake(0, 564)];
    [bezier7Path addLineToPoint: CGPointMake(411, 564)];
    [bezier7Path addLineToPoint: CGPointMake(341.5, 703)];
    [bezier7Path addLineToPoint: CGPointMake(0, 703)];
    [bezier7Path addLineToPoint: CGPointMake(0, 564)];
    [bezier7Path closePath];
    bezier7Path.miterLimit = 4;
    bezier7Path.flatness = 0;
    bezier7Path.usesEvenOddFillRule = YES;
    return bezier7Path;
}

+ (UIBezierPath*)audioControlBellIcon {
    UIBezierPath* bezier8Path = UIBezierPath.bezierPath;
    [bezier8Path moveToPoint: CGPointMake(72, 664)];
    [bezier8Path addCurveToPoint: CGPointMake(76.2, 659.8) controlPoint1: CGPointMake(74.4, 664) controlPoint2: CGPointMake(76.2, 662.2)];
    [bezier8Path addLineToPoint: CGPointMake(98, 659.8)];
    [bezier8Path addLineToPoint: CGPointMake(98, 653.8)];
    [bezier8Path addLineToPoint: CGPointMake(93, 653.8)];
    [bezier8Path addLineToPoint: CGPointMake(93, 629)];
    [bezier8Path addCurveToPoint: CGPointMake(92.6, 625.4) controlPoint1: CGPointMake(93, 627.8) controlPoint2: CGPointMake(92.8, 626.6)];
    [bezier8Path addLineToPoint: CGPointMake(92.6, 625)];
    [bezier8Path addCurveToPoint: CGPointMake(92.4, 624.4) controlPoint1: CGPointMake(92.6, 624.8) controlPoint2: CGPointMake(92.6, 624.6)];
    [bezier8Path addCurveToPoint: CGPointMake(76.2, 608.2) controlPoint1: CGPointMake(90.6, 616.2) controlPoint2: CGPointMake(84.2, 609.8)];
    [bezier8Path addCurveToPoint: CGPointMake(72, 604) controlPoint1: CGPointMake(76.2, 605.8) controlPoint2: CGPointMake(74.2, 604)];
    [bezier8Path addCurveToPoint: CGPointMake(67.8, 608.2) controlPoint1: CGPointMake(69.6, 604) controlPoint2: CGPointMake(67.8, 605.8)];
    [bezier8Path addCurveToPoint: CGPointMake(51.4, 624.4) controlPoint1: CGPointMake(59.6, 610) controlPoint2: CGPointMake(53.2, 616.4)];
    [bezier8Path addCurveToPoint: CGPointMake(51.2, 625) controlPoint1: CGPointMake(51.4, 624.6) controlPoint2: CGPointMake(51.4, 624.8)];
    [bezier8Path addLineToPoint: CGPointMake(51.2, 625.4)];
    [bezier8Path addCurveToPoint: CGPointMake(50.8, 629) controlPoint1: CGPointMake(51, 626.6) controlPoint2: CGPointMake(50.8, 627.8)];
    [bezier8Path addLineToPoint: CGPointMake(50.8, 653.6)];
    [bezier8Path addLineToPoint: CGPointMake(46, 653.6)];
    [bezier8Path addLineToPoint: CGPointMake(46, 659.6)];
    [bezier8Path addLineToPoint: CGPointMake(67.8, 659.6)];
    [bezier8Path addCurveToPoint: CGPointMake(72, 664) controlPoint1: CGPointMake(67.8, 662.2) controlPoint2: CGPointMake(69.6, 664)];
    [bezier8Path addLineToPoint: CGPointMake(72, 664)];
    [bezier8Path closePath];
    [bezier8Path moveToPoint: CGPointMake(57.4, 629)];
    [bezier8Path addCurveToPoint: CGPointMake(72, 614.4) controlPoint1: CGPointMake(57.4, 621) controlPoint2: CGPointMake(64, 614.4)];
    [bezier8Path addCurveToPoint: CGPointMake(86.6, 629) controlPoint1: CGPointMake(80, 614.4) controlPoint2: CGPointMake(86.6, 621)];
    [bezier8Path addLineToPoint: CGPointMake(86.6, 653.6)];
    [bezier8Path addLineToPoint: CGPointMake(57.4, 653.6)];
    [bezier8Path addLineToPoint: CGPointMake(57.4, 629)];
    [bezier8Path addLineToPoint: CGPointMake(57.4, 629)];
    [bezier8Path closePath];
    bezier8Path.miterLimit = 4;
    bezier8Path.flatness = 0;
    
    bezier8Path.usesEvenOddFillRule = YES;
    return bezier8Path;
}

+ (UIBezierPath*)audioControlPlusIcon {
    UIBezierPath* bezier9Path = UIBezierPath.bezierPath;
    [bezier9Path moveToPoint: CGPointMake(185.85, 605)];
    [bezier9Path addLineToPoint: CGPointMake(180.15, 605)];
    [bezier9Path addLineToPoint: CGPointMake(180.15, 630.65)];
    [bezier9Path addLineToPoint: CGPointMake(154.5, 630.65)];
    [bezier9Path addLineToPoint: CGPointMake(154.5, 636.35)];
    [bezier9Path addLineToPoint: CGPointMake(180.15, 636.35)];
    [bezier9Path addLineToPoint: CGPointMake(180.15, 662)];
    [bezier9Path addLineToPoint: CGPointMake(185.85, 662)];
    [bezier9Path addLineToPoint: CGPointMake(185.85, 636.35)];
    [bezier9Path addLineToPoint: CGPointMake(211.5, 636.35)];
    [bezier9Path addLineToPoint: CGPointMake(211.5, 630.65)];
    [bezier9Path addLineToPoint: CGPointMake(185.85, 630.65)];
    [bezier9Path addLineToPoint: CGPointMake(185.85, 605)];
    [bezier9Path closePath];
    bezier9Path.miterLimit = 4;
    bezier9Path.flatness = 0;
    
    bezier9Path.usesEvenOddFillRule = YES;
    return bezier9Path;
}

+ (UIBezierPath*)audioControlMinusIcon {
    CGRect minusPath =  CGRectMake(263, 630.5, 60, 6);
    return [UIBezierPath bezierPathWithRect:minusPath];
}

+ (UIBezierPath*)brightnessControlBackground {
    UIBezierPath* bezier6Path = UIBezierPath.bezierPath;
    [bezier6Path moveToPoint: CGPointMake(411, 564)];
    [bezier6Path addLineToPoint: CGPointMake(783, 564)];
    [bezier6Path addLineToPoint: CGPointMake(713.5, 703)];
    [bezier6Path addLineToPoint: CGPointMake(341.5, 703)];
    [bezier6Path addLineToPoint: CGPointMake(411, 564)];
    [bezier6Path closePath];
    bezier6Path.miterLimit = 4;
    bezier6Path.flatness = 0;
    
    bezier6Path.usesEvenOddFillRule = YES;
    return bezier6Path;
}

+ (UIBezierPath*)brightnessControlUpIcon {
    UIBezierPath* bezier10Path = UIBezierPath.bezierPath;
    [bezier10Path moveToPoint: CGPointMake(542.99, 646.77)];
    [bezier10Path addLineToPoint: CGPointMake(565.79, 623.98)];
    [bezier10Path addLineToPoint: CGPointMake(588.35, 646.77)];
    [bezier10Path addLineToPoint: CGPointMake(593.34, 641.79)];
    [bezier10Path addLineToPoint: CGPointMake(565.79, 614)];
    [bezier10Path addLineToPoint: CGPointMake(538, 641.79)];
    [bezier10Path addLineToPoint: CGPointMake(542.99, 646.77)];
    [bezier10Path closePath];
    bezier10Path.miterLimit = 4;
    bezier10Path.flatness = 0;
    
    bezier10Path.usesEvenOddFillRule = YES;
    return bezier10Path;
}

+ (UIBezierPath*)brightnessControlDownIcon {
    UIBezierPath* bezier11Path = UIBezierPath.bezierPath;
    [bezier11Path moveToPoint: CGPointMake(695.92, 617)];
    [bezier11Path addLineToPoint: CGPointMake(672.88, 640.04)];
    [bezier11Path addLineToPoint: CGPointMake(649.59, 617)];
    [bezier11Path addLineToPoint: CGPointMake(644.5, 622.09)];
    [bezier11Path addLineToPoint: CGPointMake(672.88, 650.47)];
    [bezier11Path addLineToPoint: CGPointMake(701.01, 622.09)];
    [bezier11Path addLineToPoint: CGPointMake(695.92, 617)];
    [bezier11Path closePath];
    bezier11Path.miterLimit = 4;
    bezier11Path.flatness = 0;
    
    bezier11Path.usesEvenOddFillRule = YES;
    return bezier11Path;
}

+ (UIBezierPath*)driverTipControlBackground {
    UIBezierPath *bezier5Path = UIBezierPath.bezierPath;
    [bezier5Path moveToPoint: CGPointMake(782.5, 564)];
    [bezier5Path addLineToPoint: CGPointMake(1024, 564)];
    [bezier5Path addLineToPoint: CGPointMake(1024, 703)];
    [bezier5Path addLineToPoint: CGPointMake(713, 703)];
    [bezier5Path addLineToPoint: CGPointMake(782.5, 564)];
    [bezier5Path closePath];
    bezier5Path.miterLimit = 4;
    bezier5Path.flatness = 0;
    
    bezier5Path.usesEvenOddFillRule = YES;
    return bezier5Path;
}

+ (UIBezierPath*)logoArrowBackground {
    UIBezierPath* bezier23Path = UIBezierPath.bezierPath;
    [bezier23Path moveToPoint: CGPointMake(103, 735.5)];
    [bezier23Path addLineToPoint: CGPointMake(75.5, 768)];
    [bezier23Path addLineToPoint: CGPointMake(0, 768)];
    [bezier23Path addLineToPoint: CGPointMake(0, 703)];
    [bezier23Path addLineToPoint: CGPointMake(75.5, 703)];
    [bezier23Path addLineToPoint: CGPointMake(103, 735.5)];
    [bezier23Path closePath];
    bezier23Path.miterLimit = 4;
    bezier23Path.flatness = 0;
    
    bezier23Path.usesEvenOddFillRule = YES;
    return bezier23Path;
}

+ (UIBezierPath*)logoArrowIcon {
    UIBezierPath* bezier24Path = UIBezierPath.bezierPath;
    [bezier24Path moveToPoint: CGPointMake(49.04, 735.37)];
    [bezier24Path addLineToPoint: CGPointMake(38.28, 729.81)];
    [bezier24Path addLineToPoint: CGPointMake(31.7, 726.39)];
    [bezier24Path addLineToPoint: CGPointMake(20.89, 720.83)];
    [bezier24Path addCurveToPoint: CGPointMake(16.61, 754.35) controlPoint1: CGPointMake(20.89, 720.83) controlPoint2: CGPointMake(24.1, 739.12)];
    [bezier24Path addLineToPoint: CGPointMake(15.59, 756.39)];
    [bezier24Path addCurveToPoint: CGPointMake(18.96, 760.66) controlPoint1: CGPointMake(15.05, 757.51) controlPoint2: CGPointMake(17.62, 760.02)];
    [bezier24Path addCurveToPoint: CGPointMake(24.31, 760.88) controlPoint1: CGPointMake(20.25, 761.36) controlPoint2: CGPointMake(23.78, 762)];
    [bezier24Path addLineToPoint: CGPointMake(24.9, 759.7)];
    [bezier24Path addLineToPoint: CGPointMake(40.37, 759.43)];
    [bezier24Path addLineToPoint: CGPointMake(42.88, 754.3)];
    [bezier24Path addLineToPoint: CGPointMake(29.08, 752.64)];
    [bezier24Path addCurveToPoint: CGPointMake(49.04, 735.37) controlPoint1: CGPointMake(37.21, 741.42) controlPoint2: CGPointMake(49.04, 735.37)];
    [bezier24Path addLineToPoint: CGPointMake(49.04, 735.37)];
    [bezier24Path closePath];
    [bezier24Path moveToPoint: CGPointMake(38.34, 720.89)];
    [bezier24Path addCurveToPoint: CGPointMake(39.94, 720.35) controlPoint1: CGPointMake(38.92, 721.21) controlPoint2: CGPointMake(39.62, 720.94)];
    [bezier24Path addLineToPoint: CGPointMake(43.63, 712.87)];
    [bezier24Path addCurveToPoint: CGPointMake(43.1, 711.26) controlPoint1: CGPointMake(43.9, 712.28) controlPoint2: CGPointMake(43.69, 711.53)];
    [bezier24Path addCurveToPoint: CGPointMake(41.49, 711.8) controlPoint1: CGPointMake(42.51, 710.94) controlPoint2: CGPointMake(41.81, 711.21)];
    [bezier24Path addLineToPoint: CGPointMake(37.8, 719.28)];
    [bezier24Path addCurveToPoint: CGPointMake(38.34, 720.89) controlPoint1: CGPointMake(37.53, 719.87) controlPoint2: CGPointMake(37.75, 720.56)];
    [bezier24Path addLineToPoint: CGPointMake(38.34, 720.89)];
    [bezier24Path closePath];
    [bezier24Path moveToPoint: CGPointMake(30.57, 719.23)];
    [bezier24Path addCurveToPoint: CGPointMake(31.16, 719.33) controlPoint1: CGPointMake(30.74, 719.33) controlPoint2: CGPointMake(30.95, 719.39)];
    [bezier24Path addCurveToPoint: CGPointMake(32.29, 718.05) controlPoint1: CGPointMake(31.81, 719.28) controlPoint2: CGPointMake(32.29, 718.75)];
    [bezier24Path addLineToPoint: CGPointMake(31.75, 709.66)];
    [bezier24Path addCurveToPoint: CGPointMake(30.52, 708.53) controlPoint1: CGPointMake(31.75, 709.02) controlPoint2: CGPointMake(31.16, 708.48)];
    [bezier24Path addCurveToPoint: CGPointMake(29.4, 709.82) controlPoint1: CGPointMake(29.88, 708.59) controlPoint2: CGPointMake(29.4, 709.12)];
    [bezier24Path addLineToPoint: CGPointMake(29.88, 718.21)];
    [bezier24Path addCurveToPoint: CGPointMake(30.57, 719.23) controlPoint1: CGPointMake(29.93, 718.64) controlPoint2: CGPointMake(30.2, 719.01)];
    [bezier24Path addLineToPoint: CGPointMake(30.57, 719.23)];
    [bezier24Path closePath];
    [bezier24Path moveToPoint: CGPointMake(52.68, 719.98)];
    [bezier24Path addCurveToPoint: CGPointMake(51.02, 719.6) controlPoint1: CGPointMake(52.3, 719.44) controlPoint2: CGPointMake(51.61, 719.28)];
    [bezier24Path addLineToPoint: CGPointMake(44.12, 724.2)];
    [bezier24Path addCurveToPoint: CGPointMake(43.79, 725.86) controlPoint1: CGPointMake(43.58, 724.57) controlPoint2: CGPointMake(43.42, 725.32)];
    [bezier24Path addCurveToPoint: CGPointMake(44.28, 726.29) controlPoint1: CGPointMake(43.9, 726.02) controlPoint2: CGPointMake(44.06, 726.18)];
    [bezier24Path addCurveToPoint: CGPointMake(45.45, 726.23) controlPoint1: CGPointMake(44.65, 726.5) controlPoint2: CGPointMake(45.08, 726.45)];
    [bezier24Path addLineToPoint: CGPointMake(52.36, 721.63)];
    [bezier24Path addCurveToPoint: CGPointMake(52.68, 719.98) controlPoint1: CGPointMake(52.89, 721.31) controlPoint2: CGPointMake(53.05, 720.56)];
    [bezier24Path addLineToPoint: CGPointMake(52.68, 719.98)];
    [bezier24Path closePath];
    bezier24Path.miterLimit = 4;
    bezier24Path.flatness = 0;
    
    bezier24Path.usesEvenOddFillRule = YES;
    return bezier24Path;
}

+ (UIBezierPath*)newsArrowBackground {
    UIBezierPath* bezier22Path = UIBezierPath.bezierPath;
    [bezier22Path moveToPoint: CGPointMake(290, 735.5)];
    [bezier22Path addLineToPoint: CGPointMake(262.5, 768)];
    [bezier22Path addLineToPoint: CGPointMake(0, 768)];
    [bezier22Path addLineToPoint: CGPointMake(0, 703)];
    [bezier22Path addLineToPoint: CGPointMake(262.5, 703)];
    [bezier22Path addLineToPoint: CGPointMake(290, 735.5)];
    [bezier22Path closePath];
    bezier22Path.miterLimit = 4;
    bezier22Path.flatness = 0;
    
    bezier22Path.usesEvenOddFillRule = YES;
    return bezier22Path;
}

+ (UIBezierPath*)newsArrowBackgroundExtended {
    UIBezierPath* bezier22Path = UIBezierPath.bezierPath;
    [bezier22Path moveToPoint: CGPointMake(890, 735.5)];
    [bezier22Path addLineToPoint: CGPointMake(862.5, 768)];
    [bezier22Path addLineToPoint: CGPointMake(0, 768)];
    [bezier22Path addLineToPoint: CGPointMake(0, 703)];
    [bezier22Path addLineToPoint: CGPointMake(862.5, 703)];
    [bezier22Path addLineToPoint: CGPointMake(890, 735.5)];
    [bezier22Path closePath];
    bezier22Path.miterLimit = 4;
    bezier22Path.flatness = 0;
    
    bezier22Path.usesEvenOddFillRule = YES;
    return bezier22Path;
}

+ (UIBezierPath*)weatherArrowBackground {
    UIBezierPath* bezier25Path = UIBezierPath.bezierPath;
    [bezier25Path moveToPoint: CGPointMake(756, 735.5)];
    [bezier25Path addLineToPoint: CGPointMake(783.5, 703)];
    [bezier25Path addLineToPoint: CGPointMake(1024, 703)];
    [bezier25Path addLineToPoint: CGPointMake(1024, 768)];
    [bezier25Path addLineToPoint: CGPointMake(783.5, 768)];
    [bezier25Path addLineToPoint: CGPointMake(756, 735.5)];
    [bezier25Path closePath];
    bezier25Path.miterLimit = 4;
    bezier25Path.flatness = 0;
    
    bezier25Path.usesEvenOddFillRule = YES;
    return bezier25Path;
}

+ (UIBezierPath*)timeArrowBackground {
    UIBezierPath* bezier26Path = UIBezierPath.bezierPath;
    [bezier26Path moveToPoint: CGPointMake(881, 735.5)];
    [bezier26Path addLineToPoint: CGPointMake(908.5, 703)];
    [bezier26Path addLineToPoint: CGPointMake(1024, 703)];
    [bezier26Path addLineToPoint: CGPointMake(1024, 768)];
    [bezier26Path addLineToPoint: CGPointMake(908.5, 768)];
    [bezier26Path addLineToPoint: CGPointMake(881, 735.5)];
    [bezier26Path closePath];
    bezier26Path.miterLimit = 4;
    bezier26Path.flatness = 0;
    
    bezier26Path.usesEvenOddFillRule = YES;
    return bezier26Path;
}

@end
