//
//  NewsHeadlineView.m
//  moneyapp
//
//  Created by Gaurav Khanna on 8/31/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "NewsHeadlineView.h"
#import "UserInterfaceVectorPaths.h"
#import "NewsAnimationView.h"

// X values between small logo arrow and weather arrow
// to figure out center of masked area
//let contentStartX = 103
//let contentEndX = 756

@interface NewsHeadlineView ()

@property (nonatomic, strong) CAShapeLayer *newsArrowLayer;
@property (nonatomic, strong) CAShapeLayer *addNewArrowLayer;

@property (nonatomic, strong) CAShapeLayer *textLayer;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, assign) CGAffineTransform vectorPathOffset;

@property (nonatomic, copy) UIColor *newsBGColor;

@property (nonatomic, strong) CAShapeLayer *textFirstLine;
@property (nonatomic, strong) CAShapeLayer *textSecondLine;

@property (nonatomic, strong) CAShapeLayer *headlineLayer;
@property (nonatomic, strong) NSDictionary *headlineAttrs;

@property (nonatomic, strong) CAShapeLayer *stationLayer;
@property (nonatomic, strong) NSDictionary *stationAttrs;
@property (nonatomic, strong) NSAttributedString *stationLiveString;

@property (nonatomic, strong) CAShapeLayer *textStation;
@property (nonatomic, assign) CGRect textStationRect;

@property (nonatomic, strong) CAShapeLayer *liveText;
@property (nonatomic, assign) CGRect liveRect;
@property (nonatomic, strong) CAShapeLayer *liveLayer;

@property (nonatomic, strong) CAShapeLayer *animLayer;
@property (nonatomic, strong) CAShapeLayer *anim2Layer;

@property (nonatomic, strong) NewsAnimationView *animationView;

@property (nonatomic, strong) NewsHeadlineItem *currentItem;

@end

@implementation NewsHeadlineView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        _newsBGColor = [UIColor colorWithRed:0.304 green:0.168 blue:0.168 alpha:1];
        _vectorPathOffset = CGAffineTransformMakeTranslation(0, -703);
        
        self.opaque = true;
        self.userInteractionEnabled = false;
        self.backgroundColor = _newsBGColor;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _maskLayer = [CAShapeLayer layer];
        [self setupMaskLayer];
        self.layer.mask = _maskLayer;
        
        const CGAffineTransform vectorOffset = _vectorPathOffset;
        UIBezierPath *newsArrowPath = [UserInterfaceVectorPaths newsArrowBackground];
        CGPathRef newsCGPath = CGPathCreateCopyByTransformingPath(newsArrowPath.CGPath, &vectorOffset);
        
        _newsArrowLayer = [CAShapeLayer layer];
        _newsArrowLayer.contentsScale = [UIScreen mainScreen].scale;
        _newsArrowLayer.opaque = true;
        _newsArrowLayer.path = newsCGPath;
        _newsArrowLayer.fillColor = [UIColor blackColor].CGColor;
        
        _addNewArrowLayer = [CAShapeLayer layer];
        _addNewArrowLayer.contentsScale = [UIScreen mainScreen].scale;
        _addNewArrowLayer.opaque = true;
        _addNewArrowLayer.path = newsCGPath;
        _addNewArrowLayer.fillColor = [UIColor colorWithRed: 0.105 green: 0.348 blue: 0.998 alpha: 1].CGColor;
        
        NSDictionary *attrs = @{
                                NSFontAttributeName: [UIFont fontWithName:@"BebasNeueRegular" size:36],
                                NSKernAttributeName: @1.25
                                };
        
        NSString *firstText = @"LOADING";
        
        NSAttributedString *firstLine = [[NSAttributedString alloc] initWithString:firstText attributes:attrs];
        
//        NSString *secText = @"IN MORE THAN 50 YEARS HAS LANDED!";
//        
//        NSAttributedString *secLine = [[NSAttributedString alloc] initWithString:secText attributes:attrs];
        
        _textFirstLine = [CAShapeLayer layer];
        _textFirstLine.contentsScale = [UIScreen mainScreen].scale;
        _textFirstLine.path = firstLine.bezierPath.CGPath;
        _textFirstLine.fillColor = [UIColor grayColor].CGColor;
        
//        _textSecondLine = [CAShapeLayer layer];
//        _textSecondLine.contentsScale = [UIScreen mainScreen].scale;
//        _textSecondLine.path = secLine.bezierPath.CGPath;
//        _textSecondLine.fillColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:_textFirstLine];
//        [self.layer addSublayer:_textSecondLine];
        
        NSString *station = @"NPR NEWS";
        
        NSDictionary *stationAttrs = @{
                                       NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBold" size:37],
                                       NSKernAttributeName: @0
                                       };
        
        NSAttributedString *stationText = [[NSAttributedString alloc] initWithString:station attributes:stationAttrs];
        
        UIBezierPath *stationPath = stationText.bezierPath;
        
        _textStationRect = CGPathGetBoundingBox(stationPath.CGPath);
        
        _textStation = [CAShapeLayer layer];
        _textStation.contentsScale = [UIScreen mainScreen].scale;
        _textStation.path = stationPath.CGPath;
        _textStation.fillColor = [UIColor grayColor].CGColor;
//        [_newsArrowLayer addSublayer:_textStation];
        
        NSString *live = @"LIVE";
        NSDictionary *liveAttrs = @{
                                    NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBook" size:37],
                                    NSKernAttributeName: @0
                                    };
        
        NSAttributedString *liveText = [[NSAttributedString alloc] initWithString:live attributes:liveAttrs];
        
        UIBezierPath *livePath = liveText.bezierPath;
        
        _liveRect = CGPathGetBoundingBox(livePath.CGPath);
        
        _liveLayer = [CAShapeLayer layer];
        _liveLayer.contentsScale = [UIScreen mainScreen].scale;
        _liveLayer.path = livePath.CGPath;
        _liveLayer.fillColor = [UIColor grayColor].CGColor;
//        [_newsArrowLayer addSublayer:_liveLayer];
        
        [self.layer addSublayer:_newsArrowLayer];
        
        // NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
        
//        NSString *text = @"LOADING";
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//        paragraphStyle.lineSpacing = 0.6;
        paragraphStyle.lineHeightMultiple = 0.76;
        
        _headlineAttrs = @{
                                NSFontAttributeName: [UIFont fontWithName:@"BebasNeueRegular" size:36],
                                NSKernAttributeName: @1.25,
                                NSParagraphStyleAttributeName: paragraphStyle
                                };
//
//        NSAttributedString *hl = [[NSAttributedString alloc] initWithString:text attributes:self.headlineAttrs];
//        
//        CGRect size = [hl boundingRectWithSize:CGSizeMake(450.5, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
//        NSLog(@"%@", NSStringFromCGRect(size));
        
        // w > 420
        // h < 55
        
        _headlineLayer = [CAShapeLayer layer];
        _headlineLayer.contentsScale = [UIScreen mainScreen].scale;
        _headlineLayer.fillColor = [UIColor whiteColor].CGColor;
        
//        _headlineLayer.path = [hl bezierPathWithMultilineFittingSize:CGSizeMake(450.5, 66)].CGPath;
//        _headlineLayer.path = hl.bezierPath.CGPath;
        [self.layer addSublayer:_headlineLayer];
        
        
        _stationAttrs = @{
                          NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBold" size:37],
                          NSKernAttributeName: @0,
                          NSParagraphStyleAttributeName: paragraphStyle
                          };
        
        NSDictionary *liveStringAttrs = @{
                                          NSFontAttributeName: [UIFont fontWithName:@"BebasNeueBook" size:37],
                                          NSKernAttributeName: @0,
                                          NSParagraphStyleAttributeName: paragraphStyle
                                          };
        
//        NSMutableAttributedString *test = [[NSMutableAttributedString alloc] initWithString:@"HUFFINGTON POST" attributes:_stationAttrs];
        
        _stationLiveString = [[NSAttributedString alloc] initWithString:@" LIVE" attributes:liveStringAttrs];
       
//        [test appendAttributedString:_stationLiveString];
        
        
        
        _stationLayer = [CAShapeLayer layer];
        _stationLayer.contentsScale = [UIScreen mainScreen].scale;
//        _stationLayer.path = [test bezierPathWithMultilineFittingSize:CGSizeMake(146, 68)].CGPath;
        _stationLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.newsArrowLayer addSublayer:_stationLayer];
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskLayer.frame = self.layer.bounds;
    self.newsArrowLayer.frame = self.layer.bounds;
    
    CGFloat lineHeight = self.newsArrowLayer.bounds.size.height/2;
    
    CGFloat stationTextHeight = self.textStationRect.size.height;
    //    self.textStation.frame = CGRectMake(170, self.newsArrowLayer.bounds.size.height / 2 - stationTextHeight / 2, self.textStationRect.size.width, stationTextHeight);
    
    self.textStation.frame = CGRectAlign(CGRectMake(125.5, 5, 116, lineHeight));
    
    CGFloat liveHeight = self.liveRect.size.height;
    self.liveLayer.frame = CGRectAlign(CGRectMake(125.5, lineHeight + 4, 116, lineHeight));
    
    self.textFirstLine.frame = CGRectAlign(CGRectMake(299, 5, 450.5, lineHeight));
    self.textSecondLine.frame = CGRectAlign(CGRectMake(299, lineHeight + 4, 450.5, lineHeight));
    
    self.headlineLayer.frame = CGRectAlign(CGRectMake(299, 6, 450.5, self.layer.bounds.size.height - 6));
    
    self.animationView.frame = self.bounds;
    
    self.stationLayer.frame = CGRectAlign(CGRectMake(110, 6, 146, self.layer.bounds.size.height - 6));
}

+ (BOOL)validHeadline:(NSString*)text {
    NSArray *words = [text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (words.count > 3) {
    
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        //        paragraphStyle.lineSpacing = 0.6;
        paragraphStyle.lineHeightMultiple = 0.76;
        
        NSDictionary *textAttrs = @{
                                    NSFontAttributeName: [UIFont fontWithName:@"BebasNeueRegular" size:36],
                                    NSKernAttributeName: @1.25,
                                    NSParagraphStyleAttributeName: paragraphStyle
                                    };
        
        NSAttributedString *hl = [[NSAttributedString alloc] initWithString:text attributes:textAttrs];
        
        CGRect rect = [hl boundingRectWithSize:CGSizeMake(450.5, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
//        DLog(@"%@", NSStringFromCGRect(rect));
    
        // w > 420
        // h < 55
        
        if (rect.size.height < 55) {
            return true;
        }
        return false;
    }
    return false;
}



- (void)startAnimatingHeadlines {
    self.textFirstLine.hidden = true;
    
    self.currentItem = [self.viewModel nextHeadlineWithHeadline:nil];

    NSAttributedString *hl = [[NSAttributedString alloc] initWithString:self.currentItem.headline attributes:self.headlineAttrs];

    self.headlineLayer.path = [hl bezierPathWithMultilineFittingSize:CGSizeMake(450.5, 66)].CGPath;
    
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:self.currentItem.site attributes:self.stationAttrs];
    
    [s appendAttributedString:self.stationLiveString];
    
    self.stationLayer.path = [s bezierPathWithMultilineFittingSize:CGSizeMake(146, 68)].CGPath;
    
    CABasicAnimation *fadeFirst = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeFirst.duration = 1;
    fadeFirst.toValue = @0;
    fadeFirst.delegate = self;
    fadeFirst.fillMode = kCAFillModeForwards;
    fadeFirst.removedOnCompletion = false;
    [self.headlineLayer addAnimation:fadeFirst forKey:@"animFadeOut"];
    [self.stationLayer addAnimation:fadeFirst forKey:@"animFadeOut"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && [self.headlineLayer animationForKey:@"animFadeOut"] == anim) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.0];

        self.headlineLayer.opacity = 0;
        self.stationLayer.opacity = 0;
        
        self.currentItem = [self.viewModel nextHeadlineWithHeadline:self.currentItem];
        
        NSAttributedString *hl = [[NSAttributedString alloc] initWithString:self.currentItem.headline attributes:self.headlineAttrs];
        
        CGRect rect = [hl boundingRectWithSize:CGSizeMake(450.5, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
//        NSLog(@"showing headline: %@", self.currentItem.headline);
//        NSLog(@"%@", NSStringFromCGRect(rect));
        
        if (rect.size.height < 35) {
            NSDictionary *singleLineAttrs = @{
                               NSFontAttributeName: [UIFont fontWithName:@"BebasNeueRegular" size:36],
                               NSKernAttributeName: @1.25
                               };
            
            NSAttributedString *h2 = [[NSAttributedString alloc] initWithString:self.currentItem.headline attributes:singleLineAttrs];
            self.headlineLayer.path = [h2 bezierPath].CGPath;
        } else {
            
            self.headlineLayer.path = [hl bezierPathWithMultilineFittingSize:CGSizeMake(450.5, 66)].CGPath;
        }
        
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:self.currentItem.site attributes:self.stationAttrs];
        
        [s appendAttributedString:self.stationLiveString];
        
        CGRect rect2 = [s boundingRectWithSize:CGSizeMake(146, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
//        NSLog(@"showing site: %@", self.currentItem.site);
//        NSLog(@"%@", NSStringFromCGRect(rect2));
        
        if (rect2.size.height < 35) {
            self.stationLayer.path = s.bezierPath.CGPath;
        } else {
        
            self.stationLayer.path = [s bezierPathWithMultilineFittingSize:CGSizeMake(146, 68)].CGPath;
        }
        
        [CATransaction commit];

        [self.headlineLayer removeAllAnimations];
        [self.stationLayer removeAllAnimations];
        
        CABasicAnimation *fadeFirst = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeFirst.duration = 1;
        fadeFirst.toValue = @1;
        fadeFirst.delegate = self;
        fadeFirst.fillMode = kCAFillModeForwards;
        fadeFirst.removedOnCompletion = false;
        [self.headlineLayer addAnimation:fadeFirst forKey:@"animFadeIn"];
        [self.stationLayer addAnimation:fadeFirst forKey:@"animFadeIn"];
    } else if (flag && [self.headlineLayer animationForKey:@"animFadeIn"] == anim) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.0];
        self.headlineLayer.opacity = 1;
        self.stationLayer.opacity = 1;
        [CATransaction commit];
        
        [self.headlineLayer removeAllAnimations];
        [self.stationLayer removeAllAnimations];
        
        CABasicAnimation *fadeFirst = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeFirst.duration = 1;
        fadeFirst.toValue = @0;
        fadeFirst.beginTime = CACurrentMediaTime() + 6;
        fadeFirst.delegate = self;
        fadeFirst.fillMode = kCAFillModeForwards;
        fadeFirst.removedOnCompletion = false;
        [self.headlineLayer addAnimation:fadeFirst forKey:@"animFadeOut"];
        [self.stationLayer addAnimation:fadeFirst forKey:@"animFadeOut"];
    }
}


- (void)animateNewHeadline {
    const CGAffineTransform vectorOffset = self.vectorPathOffset;
    
    UIBezierPath *newsArrowExtPath = [UserInterfaceVectorPaths newsArrowBackgroundExtended];
    CGPathRef newsCGPath = CGPathCreateCopyByTransformingPath(newsArrowExtPath.CGPath, &vectorOffset);
    
    self.addNewArrowLayer.path = newsCGPath;
    
    self.addNewArrowLayer.frame = CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height);
    [self.layer addSublayer:self.addNewArrowLayer];
    [self setNeedsLayout];
    
    self.addNewArrowLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(-1500, 0));
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration = 1.5;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(1500, 0))];
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = false;
    [self.addNewArrowLayer addAnimation:anim forKey:@"pathAnimation"];
    
    _animLayer = [CAShapeLayer layer];
    _animLayer.contentsScale = [UIScreen mainScreen].scale;
    _animLayer.path = newsCGPath;
    _animLayer.fillColor = [UIColor whiteColor].CGColor;
    _animLayer.frame = self.layer.bounds;
    [self.layer addSublayer:_animLayer];
    [self setNeedsLayout];
    _animLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(-1500, 0));
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim2.duration = 1.5;
    anim2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(1500, 0))];
    anim2.beginTime = CACurrentMediaTime() + 0.15;
    anim2.fillMode = kCAFillModeForwards;
    anim2.removedOnCompletion = false;
    [_animLayer addAnimation:anim2 forKey:@"pathAnimation"];
    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
//    anim.toValue = (__bridge id)newsCGPath;
//    anim.duration = 0.6;
//    anim.delegate = self;
//    anim.fillMode = kCAFillModeForwards;
//    anim.removedOnCompletion = false;
//    [self.newsArrowLayer addAnimation:anim forKey:@"pathAnimation"];
//    
//    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"fillColor"];
//    color.toValue = (id)[UIColor colorWithRed:0.304 green:0.168 blue:0.168 alpha:1].CGColor;
//    color.duration = 1.0;
//    color.delegate = self;
//    color.removedOnCompletion = false;
//    color.fillMode = kCAFillModeForwards;
////    [self.newsArrowLayer addAnimation:color forKey:@"colorAnimation"];
    
    CGPathRelease(newsCGPath);
}



- (void)setupMaskLayer {
    
    const CGAffineTransform vectorOffset = self.vectorPathOffset;
    
    UIBezierPath *logoArrowPath = [UserInterfaceVectorPaths logoArrowBackground];
    CGPathRef logoCGPath = CGPathCreateCopyByTransformingPath(logoArrowPath.CGPath, &vectorOffset);

    UIBezierPath *weatherArrowPath = [UserInterfaceVectorPaths weatherArrowBackground];
    CGPathRef weatherCGPath = CGPathCreateCopyByTransformingPath(weatherArrowPath.CGPath, &vectorOffset);

    UIBezierPath *maskPath = [UIBezierPath new];
    [maskPath appendPath:[UIBezierPath bezierPathWithCGPath:logoCGPath]];
    [maskPath appendPath:[UIBezierPath bezierPathWithCGPath:weatherCGPath]];
    maskPath.flatness = 1;
    
    // to invert the above path as needed for masking
    CGMutablePathRef invertPath = CGPathCreateMutable();
    CGPathAddRect(invertPath, nil, CGRectMake(0, 0, 1024, 768 - 703));
    // then add the path to invert
    CGPathAddPath(invertPath, nil, maskPath.CGPath);
    
    self.maskLayer.contentsScale = [UIScreen mainScreen].scale;
    self.maskLayer.opaque = true;
    self.maskLayer.path = invertPath;
    // the fill rule casues the invert
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPathRelease(logoCGPath);
    CGPathRelease(weatherCGPath);
    CGPathRelease(invertPath);
}

@end
