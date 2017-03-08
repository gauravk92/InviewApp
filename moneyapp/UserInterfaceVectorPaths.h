//
//  UserInterfaceVectorPaths.h
//  Money
//
//  Created by Gaurav Khanna on 7/29/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UserInterfaceVectorPaths : NSObject

+ (UIBezierPath*)audioControlBackground;
+ (UIBezierPath*)audioControlBellIcon;
+ (UIBezierPath*)audioControlPlusIcon;
+ (UIBezierPath*)audioControlMinusIcon;

+ (UIBezierPath*)brightnessControlBackground;
+ (UIBezierPath*)brightnessControlUpIcon;
+ (UIBezierPath*)brightnessControlDownIcon;

+ (UIBezierPath*)driverTipControlBackground;

+ (UIBezierPath*)logoArrowBackground;
+ (UIBezierPath*)logoArrowIcon;

+ (UIBezierPath*)newsArrowBackground;
+ (UIBezierPath*)newsArrowBackgroundExtended;

+ (UIBezierPath*)weatherArrowBackground;

+ (UIBezierPath*)timeArrowBackground;
@end
