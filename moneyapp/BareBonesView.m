//
//  BareBonesView.m
//  Money
//
//  Created by Gaurav Khanna on 7/28/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//


#import "BareBonesView.h"

@implementation BareBonesView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        _highlightControlState = BareBonesViewStateDefault;
        _audioControlPlusRect = CGRectMake(128, 579, 108.5, 108.5);
        _audioControlMinusRect = CGRectMake(236.5, 579, 108.5, 108.5);
        _brightnessUpRect = CGRectMake(510.5, 579, 108.5, 108.5);
        _brightnessDownRect = CGRectMake(616.25, 579, 108.5, 108.5);
        _timeRect = CGRectMake(910, 705.5, 106, 74);
        _dateRect = CGRectMake(910, 736.5, 106, 74);
        _timeString = @"TIME";
        _dateString = @"DATE";
        _weatherString = @"-°";
        _weatherRect = CGRectMake(785, 708, 100, 138);
        _venmoRect = CGRectMake(879, 580, 288, 48);
        _paypalRect = CGRectMake(877, 623, 288, 48);
        _venmoString = @"dudechosen";
        _paypalString = @"415-215-2331";
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSLog(@"drawing bare bones..%@", NSStringFromCGRect(rect));
    
    //// Color Declarations
    UIColor* white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* headlineNewsColorGray = [UIColor colorWithRed: 0.304 green: 0.168 blue: 0.168 alpha: 1];
    UIColor* venmoTeal = [UIColor colorWithRed: 0.194 green: 0.507 blue: 0.764 alpha: 1];
    UIColor* brightnessControlGreen = [UIColor colorWithRed: 0.266 green: 0.522 blue: 0.042 alpha: 1];
    UIColor* weatherArrowRed = [UIColor colorWithRed: 0.896 green: 0.305 blue: 0.245 alpha: 1];
    UIColor* driverTipSecondColor = [UIColor colorWithRed: 0.451 green: 0.271 blue: 0.271 alpha: 1];
    UIColor* driverTipGreen = [UIColor colorWithRed: 0.15 green: 0.802 blue: 0.021 alpha: 0.9];
    UIColor* timeArrowWhite = [UIColor colorWithRed: 0.961 green: 0.976 blue: 0.97 alpha: 1];
    UIColor* snapchatOutlineBlack = [UIColor colorWithRed: 0.042 green: 0.045 blue: 0.038 alpha: 1];
    UIColor* paypalPurple = [UIColor colorWithRed: 0.005 green: 0.123 blue: 0.454 alpha: 1];
    UIColor* blackNewsArrow = [UIColor colorWithRed: 0.059 green: 0.059 blue: 0.059 alpha: 1];
    UIColor* logoBackgroundBlue = [UIColor colorWithRed: 0.105 green: 0.348 blue: 0.998 alpha: 1];
    UIColor* snapchatYellow = [UIColor colorWithRed: 1 green: 1 blue: 0.041 alpha: 1];
    UIColor* audioControlBlue = [UIColor colorWithRed: 0 green: 0.059 blue: 0.838 alpha: 1];
    UIColor* timeTextColor = [UIColor colorWithRed: 0.185 green: 0.185 blue: 0.185 alpha: 1];
    

    //// Snapchat-Ad
            
    //// Rectangle Drawing
    CGRect contentRect = CGRectMake(0, 0, 1024, 564);
    if (CGRectIntersectsRect(rect, contentRect)) {
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: contentRect];
        [snapchatYellow setFill];
        [rectanglePath fill];
    }

    
    //// snap-ghost
    UIBezierPath *ghostBodyPath = [SnapchatVectorPaths snapchatGhostBody];
    CGRect ghostBodyRect = CGPathGetPathBoundingBox(ghostBodyPath.CGPath);
    if (CGRectIntersectsRect(rect, ghostBodyRect)) {
        [white setFill];
        [ghostBodyPath fill];
    }
    
    UIBezierPath *ghostOutlinePath = [SnapchatVectorPaths snapchatGhostOutline];
    CGRect ghostOutlineRect = CGPathGetPathBoundingBox(ghostOutlinePath.CGPath);
    if (CGRectIntersectsRect(rect, ghostOutlineRect)) {
        [snapchatOutlineBlack setFill];
        [ghostOutlinePath fill];
    }
        
        
    //// Action-Area-BG
    CGRect driverTipSecondRect = CGRectMake(0,767.5-203.5, 1024, 203.5);
    if (CGRectIntersectsRect(rect, driverTipSecondRect)) {
        UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect:driverTipSecondRect];
        [driverTipSecondColor setFill];
        [rectangle3Path fill];
    }
    
    
    //// Driver Tip BG
    UIBezierPath* bezier5Path = [UserInterfaceVectorPaths driverTipControlBackground];
    CGRect bezier5Rect = CGPathGetPathBoundingBox(bezier5Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier5Rect)) {
        [driverTipGreen setFill];
        [bezier5Path fill];
    }
    
    
    //// Brightness Control BG
    UIBezierPath* bezier6Path = [UserInterfaceVectorPaths brightnessControlBackground];
    CGRect bezier6Rect = CGPathGetPathBoundingBox(bezier6Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier6Rect)) {
        [brightnessControlGreen setFill];
        [bezier6Path fill];
    }
    
    
    //// Audio Control Background
    UIBezierPath* bezier7Path = [UserInterfaceVectorPaths audioControlBackground];
    CGRect bezier7Rect = CGPathGetPathBoundingBox(bezier7Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier7Rect)) {
        [audioControlBlue setFill];
        [bezier7Path fill];
    }
        
        
    //// bell-icon
    UIBezierPath* bellPath = [UserInterfaceVectorPaths audioControlBellIcon];
    CGRect bellRect = CGPathGetPathBoundingBox(bellPath.CGPath);
    if (CGRectIntersectsRect(rect, bellRect)) {
        [white setFill];
        [bellPath fill];
    }
        
            
    
    //// BRIGHTNESS ICON
    CGRect ovalRect =  CGRectMake(481.5,636.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, ovalRect)) {
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
        [white setFill];
        [ovalPath fill];
    }
    
    CGRect oval2Rect = CGRectMake(427.5, 636.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval2Rect)) {
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect:oval2Rect];
        [white setFill];
        [oval2Path fill];
    }
    
    CGRect oval3Rect = CGRectMake(454.5, 609.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval3Rect)) {
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect:oval3Rect];
        [white setFill];
        [oval3Path fill];
    }
    
    CGRect oval4Rect = CGRectMake(454.5, 663.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval4Rect)) {
        UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect:oval4Rect];
        [white setFill];
        [oval4Path fill];
    }
    
    CGRect oval5Rect = CGRectMake(473.5, 655.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval5Rect)) {
        UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect:oval5Rect];
        [white setFill];
        [oval5Path fill];
    }
    
    CGRect oval6Rect = CGRectMake(435.5, 617.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval6Rect)) {
        UIBezierPath* oval6Path = [UIBezierPath bezierPathWithOvalInRect:oval6Rect];
        [white setFill];
        [oval6Path fill];
    }
    
    CGRect oval7Rect = CGRectMake(473.5, 617.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval7Rect)) {
        UIBezierPath* oval7Path = [UIBezierPath bezierPathWithOvalInRect:oval7Rect];
        [white setFill];
        [oval7Path fill];
    }
    
    CGRect oval8Rect = CGRectMake(435.5, 655.5 - 6.0, 6, 6);
    if (CGRectIntersectsRect(rect, oval8Rect)) {
        UIBezierPath* oval8Path = [UIBezierPath bezierPathWithOvalInRect:oval8Rect];
        [white setFill];
        [oval8Path fill];
    }
    
    CGRect oval9Rect = CGRectMake(442.5, 648.5 - 30.0, 30, 30);
    if (CGRectIntersectsRect(rect, oval9Rect)) {
        UIBezierPath* oval9Path = [UIBezierPath bezierPathWithOvalInRect:oval9Rect];
        [white setFill];
        [oval9Path fill];
    }
    
    ///minus-icon
    if (self.highlightControlState == BareBonesViewStateHighlightAudioControlMinus) {
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:self.audioControlMinusRect];
        CGRect ovalRect = CGPathGetPathBoundingBox(ovalPath.CGPath);
        if (CGRectIntersectsRect(rect, ovalRect)) {
            [white setFill];
            [ovalPath fill];
        }
        UIBezierPath* rectangle4Path = [UserInterfaceVectorPaths audioControlMinusIcon];
        CGRect minusPathRect = CGPathGetPathBoundingBox(rectangle4Path.CGPath);
        if (CGRectIntersectsRect(rect, minusPathRect)) {
            [audioControlBlue setFill];
            [rectangle4Path fill];
            [audioControlBlue setStroke];
            rectangle4Path.lineWidth = 2;
            [rectangle4Path stroke];
        }
    } else {
        UIBezierPath* rectangle4Path = [UserInterfaceVectorPaths audioControlMinusIcon];
        CGRect minusPathRect = CGPathGetPathBoundingBox(rectangle4Path.CGPath);
        if (CGRectIntersectsRect(rect, minusPathRect)) {
            [white setFill];
            [rectangle4Path fill];
        }
    }
    
    //// plus-icon
    if (self.highlightControlState == BareBonesViewStateHighlightAudioControlPlus) {
        UIBezierPath* oval10Path = [UIBezierPath bezierPathWithOvalInRect:self.audioControlPlusRect];
        CGRect oval10Rect = CGPathGetPathBoundingBox(oval10Path.CGPath);
        if (CGRectIntersectsRect(rect, oval10Rect)) {
            [white setFill];
            [oval10Path fill];
        }
        
        UIBezierPath* plusPath = [UserInterfaceVectorPaths audioControlPlusIcon];
        CGRect plusPathRect = CGPathGetPathBoundingBox(plusPath.CGPath);
        if (CGRectIntersectsRect(rect, plusPathRect)) {
            [audioControlBlue setFill];
            [plusPath fill];
            [audioControlBlue setStroke];
            plusPath.lineWidth = 2;
            [plusPath stroke];
        }
    } else {
        UIBezierPath *bezier9Path = [UserInterfaceVectorPaths audioControlPlusIcon];
        CGRect plusPathRect = CGPathGetPathBoundingBox(bezier9Path.CGPath);
        if (CGRectIntersectsRect(rect, plusPathRect)) {
            [white setFill];
            [bezier9Path fill];
        }
    }
    
    ///brightness-up
    if (self.highlightControlState == BareBonesViewStateHighlightBrightnessControlUp) {
        UIBezierPath* ovalUpPath = [UIBezierPath bezierPathWithOvalInRect:self.brightnessUpRect];
        CGRect ovalUpRect = CGPathGetPathBoundingBox(ovalUpPath.CGPath);
        if (CGRectIntersectsRect(rect, ovalUpRect)) {
            [white setFill];
            [ovalUpPath fill];
        }
        UIBezierPath* upPath = [UserInterfaceVectorPaths brightnessControlUpIcon];
        CGRect upPathRect = CGPathGetPathBoundingBox(upPath.CGPath);
        if (CGRectIntersectsRect(rect, upPathRect)) {
            [brightnessControlGreen setFill];
            [upPath fill];
            [brightnessControlGreen setStroke];
            upPath.lineWidth = 2;
            [upPath stroke];
        }
    } else {
        UIBezierPath* upPath = [UserInterfaceVectorPaths brightnessControlUpIcon];
        CGRect upPathRect = CGPathGetPathBoundingBox(upPath.CGPath);
        if (CGRectIntersectsRect(rect, upPathRect)) {
            [white setFill];
            [upPath fill];
        }
    }
    
    //brightness-down
    if (self.highlightControlState == BareBonesViewStateHighlightBrightnessControlDown) {
        UIBezierPath* ovalDownPath = [UIBezierPath bezierPathWithOvalInRect:self.brightnessDownRect];
        CGRect ovalDownRect = CGPathGetPathBoundingBox(ovalDownPath.CGPath);
        if (CGRectIntersectsRect(rect, ovalDownRect)) {
            [white setFill];
            [ovalDownPath fill];
        }
        UIBezierPath* downPath = [UserInterfaceVectorPaths brightnessControlDownIcon];
        CGRect downPathRect = CGPathGetPathBoundingBox(downPath.CGPath);
        if (CGRectIntersectsRect(rect, downPathRect)) {
            [brightnessControlGreen setFill];
            [downPath fill];
            [brightnessControlGreen setStroke];
            downPath.lineWidth = 2;
            [downPath stroke];
        }
        
        
    } else {
        UIBezierPath* downPath = [UserInterfaceVectorPaths brightnessControlDownIcon];
        CGRect downPathRect = CGPathGetPathBoundingBox(downPath.CGPath);
        if (CGRectIntersectsRect(rect, downPathRect)) {
            [white setFill];
            [downPath fill];
        }
    }
    
    //// Tipping-Box
    //// Thank-you-Text-CHECKMARK
    
    UIBezierPath *smallCheckmarkRing = [DriverTipVectorPaths smallCheckmarkRing];
    CGRect smallCheckmarkRingRect = CGPathGetPathBoundingBox(smallCheckmarkRing.CGPath);
    if (CGRectIntersectsRect(rect, smallCheckmarkRingRect)) {
        [white setFill];
        [smallCheckmarkRing fill];
    }
    
    UIBezierPath* bezier13Path = [DriverTipVectorPaths smallCheckmarkPathOne];
    CGRect bezier13Rect = CGPathGetPathBoundingBox(bezier13Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier13Rect)) {
        [white setFill];
        [bezier13Path fill];
    }
    
    
    UIBezierPath* bezier14Path = [DriverTipVectorPaths smallCheckmarkPathTwo];
    CGRect bezier14Rect = CGPathGetPathBoundingBox(bezier14Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier14Rect)) {
        [white setFill];
        [bezier14Path fill];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"GothamBold-Italic" size:16],
                                 NSKernAttributeName: [NSNumber numberWithFloat:-0.29],
                                 NSForegroundColorAttributeName: white,
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    
    CGRect noteLineOneRect = CGRectMake(739.79, 662.32, 528, 32);
    NSString *noteLineOne = @"Thank you for riding, and please ";
    if (CGRectIntersectsRect(rect, noteLineOneRect)) {
        [noteLineOne drawInRect:noteLineOneRect withAttributes:attributes];
    }
    
    CGRect noteLineTwoRect = CGRectMake(727.06, 680.82, 592, 32);
    NSString *noteLineTwo = @"leave a tip if you enjoyed your ride!";
    if (CGRectIntersectsRect(rect, noteLineTwoRect)) {
        [noteLineTwo drawInRect:noteLineTwoRect withAttributes:attributes];
    }
    
    
    
    ///// VENMO BOX
    CGRect venmoBoxRect = CGRectMake(791.5, 609.5 - 39.0, 222, 39);
    if (CGRectIntersectsRect(rect, venmoBoxRect)) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:venmoBoxRect cornerRadius: 9];
        [venmoTeal setFill];
        [roundedRectanglePath fill];
    }
    ///// VENMO LOGO
    // "V"
    UIBezierPath* bezier15Path = [VenmoVectorPaths venmoLogoV];
    CGRect bezier15Rect = CGPathGetPathBoundingBox(bezier15Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier15Rect)) {
        [white setFill];
        [bezier15Path fill];
    }
    
    // "E"
    UIBezierPath* bezier19Path = [VenmoVectorPaths venmoLogoE];
    CGRect bezier19Rect = CGPathGetPathBoundingBox(bezier19Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier19Rect)) {
        [white setFill];
        [bezier19Path fill];
    }
    
    // "N"
    UIBezierPath* bezier16Path = [VenmoVectorPaths venmoLogoN];
    CGRect bezier16Rect = CGPathGetPathBoundingBox(bezier16Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier16Rect)) {
        [white setFill];
        [bezier16Path fill];
    }
    
    // "M"
    UIBezierPath* bezier17Path = [VenmoVectorPaths venmoLogoM];
    CGRect bezier17Rect = CGPathGetPathBoundingBox(bezier17Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier17Rect)) {
        [white setFill];
        [bezier17Path fill];
    }
    
    // "O"
    UIBezierPath* bezier18Path = [VenmoVectorPaths venmoLogoO];
    CGRect bezier18Rect = CGPathGetPathBoundingBox(bezier18Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier18Rect)) {
        [white setFill];
        [bezier18Path fill];
    }
    
    
    //// PAYPAL-BUTTON
    CGRect paypalBGRect = CGRectMake(791.5, 653 - 39, 222, 39);
    if (CGRectIntersectsRect(rect, paypalBGRect)) {
        UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPathWithRoundedRect:paypalBGRect cornerRadius: 9];
        [paypalPurple setFill];
        [roundedRectangle2Path fill];
    }
    
    //// PAYPAL LOGO
    UIBezierPath* bezier20Path = [PayPalVectorPaths paypalLogoPay];
    CGRect bezier20Rect = CGPathGetPathBoundingBox(bezier20Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier20Rect)) {
        [white setFill];
        [bezier20Path fill];
    }
    UIBezierPath* bezier21Path = [PayPalVectorPaths paypalLogoPal];
    CGRect bezier21Rect = CGPathGetPathBoundingBox(bezier21Path.CGPath);
    if (CGRectIntersectsRect(rect, bezier21Rect)) {
        [white setFill];
        [bezier21Path fill];
    }
    

    //// News Headline Rect
    /// NOT USED CURRENTLY HERE FOR REF
//    CGRect newsHeadlineRect = CGRectMake(67, 703, 744, 65);
//    if (CGRectIntersectsRect(rect, newsHeadlineRect)) {
//    UIBezierPath* rectangle9Path = [UIBezierPath bezierPathWithRect:newsHeadlineRect];
//        [headlineNewsColorGray setFill];
//        [rectangle9Path fill];
//    }
//
//
//    //// News arrow
//    UIBezierPath* newsArrowPath = [UserInterfaceVectorPaths newsArrowBackground];
//    CGRect newsArrowRect = CGPathGetPathBoundingBox(newsArrowPath.CGPath);
//    if (CGRectIntersectsRect(rect, newsArrowRect)) {
//        [blackNewsArrow setFill];
//        [newsArrowPath fill];
//    }
    
    //// Logo Arrow
    UIBezierPath* logoArrowPath = [UserInterfaceVectorPaths logoArrowBackground];
    CGRect logoArrowRect = CGPathGetPathBoundingBox(logoArrowPath.CGPath);
    if (CGRectIntersectsRect(rect, logoArrowRect)) {
        [logoBackgroundBlue setFill];
        [logoArrowPath fill];
    }
    
    //// small-logo-white
    UIBezierPath* logoArrowIconPath = [UserInterfaceVectorPaths logoArrowIcon];
    CGRect logoArrowIconRect = CGPathGetPathBoundingBox(logoArrowIconPath.CGPath);
    if (CGRectIntersectsRect(rect, logoArrowIconRect)) {
        [white setFill];
        [logoArrowIconPath fill];
    }
    
    
    //// HOT-Weather-Temp-Bar
   UIBezierPath* weatherArrowPath = [UserInterfaceVectorPaths weatherArrowBackground];
    CGRect weatherArrowRect = CGPathGetPathBoundingBox(weatherArrowPath.CGPath);
    if (CGRectIntersectsRect(rect, weatherArrowRect)) {
        [weatherArrowRed setFill];
        [weatherArrowPath fill];
    }
    
    //// Time-Bar
    UIBezierPath* timeArrowPath = [UserInterfaceVectorPaths timeArrowBackground];
    CGRect timeArrowRect = CGPathGetPathBoundingBox(timeArrowPath.CGPath);
    if (CGRectIntersectsRect(rect, timeArrowRect)) {
        [timeArrowWhite setFill];
        [timeArrowPath fill];
    }
    
    
    NSMutableParagraphStyle *tipParagraphStyle = [NSMutableParagraphStyle new];
    tipParagraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *tipTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBold" size:24],
                                          NSForegroundColorAttributeName: white,
                                          NSParagraphStyleAttributeName: tipParagraphStyle
                                          };
    
    if (CGRectIntersectsRect(rect, self.venmoRect)) {
        [self.venmoString drawInRect:self.venmoRect withAttributes:tipTextAttributes];
    }
    
    if (CGRectIntersectsRect(rect, self.paypalRect)) {
        [self.paypalString drawInRect:self.paypalRect withAttributes:tipTextAttributes];
    }
    
    NSMutableParagraphStyle *weatherParagraphStyle = [NSMutableParagraphStyle new];
    weatherParagraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *weatherAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBold" size:70],
                                        NSForegroundColorAttributeName: white,
                                        NSParagraphStyleAttributeName: weatherParagraphStyle
                                        };
    if (CGRectIntersectsRect(rect, self.weatherRect)) {
        [self.weatherString drawInRect:self.weatherRect withAttributes:weatherAttributes];
    }
    
    NSMutableParagraphStyle *timeParagraphStyle = [NSMutableParagraphStyle new];
    timeParagraphStyle.alignment = NSTextAlignmentRight;
    
    NSDictionary *timeAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBold" size:37],
                                     NSForegroundColorAttributeName: timeTextColor,
                                     NSParagraphStyleAttributeName: timeParagraphStyle
                                     };
    
    if (CGRectIntersectsRect(rect, self.timeRect)) {
        [self.timeString drawInRect:self.timeRect withAttributes:timeAttributes];
    }
    
    if (CGRectIntersectsRect(rect, self.dateRect)) {
        [self.dateString drawInRect:self.dateRect withAttributes:timeAttributes];
    }
    
}


@end
