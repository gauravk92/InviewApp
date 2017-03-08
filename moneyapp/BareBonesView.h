//
//  BareBonesView.h
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserInterfaceVectorPaths.h"
#import "SnapchatVectorPaths.h"
#import "DriverTipVectorPaths.h"
#import "VenmoVectorPaths.h"
#import "PaypalVectorPaths.h"

typedef NS_ENUM(NSInteger, BareBonesViewState) {
    BareBonesViewStateDefault = 1,
    BareBonesViewStateHighlightAudioControlPlus = 2,
    BareBonesViewStateHighlightAudioControlMinus = 3,
    BareBonesViewStateHighlightBrightnessControlUp = 4,
    BareBonesViewStateHighlightBrightnessControlDown = 5
};

@interface BareBonesView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (assign) BareBonesViewState highlightControlState;

@property (assign) CGRect audioControlPlusRect;
@property (assign) CGRect audioControlMinusRect;
@property (assign) CGRect brightnessUpRect;
@property (assign) CGRect brightnessDownRect;

@property (nonatomic, copy) NSString *weatherString;
@property (assign) CGRect weatherRect;

@property (nonatomic, copy) NSString *timeString;
@property (assign) CGRect timeRect;

@property (nonatomic, copy) NSString *dateString;
@property (assign) CGRect dateRect;

@property (nonatomic, copy) NSString *venmoString;
@property (assign) CGRect venmoRect;

@property (nonatomic, copy) NSString *paypalString;
@property (assign) CGRect paypalRect;

@property (nonatomic, strong) CALayer *newsLayer;

@end
