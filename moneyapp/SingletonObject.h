//
//  SingletonObject.h
//  Money
//
//  Created by Gaurav Khanna on 7/31/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "make_singleton.h"

@interface SingletonObject : NSObject

+ (instancetype)sharedInstance;

@end
