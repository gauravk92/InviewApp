//
//  NSString+SHA1.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/22/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "NSString+SHA1.h"

@implementation NSString (SHA1)

- (NSString *)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, [NSNumber numberWithUnsignedInteger:data.length].unsignedIntValue, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
