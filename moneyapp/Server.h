//
//  Server.h
//  Money
//
//  Created by Gaurav Khanna on 3/7/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#ifndef Server_h
#define Server_h

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "DDLogMacros.h"
#import "DDTTYLogger.h"
#import "HTTPServer.h"

@protocol ServerProtocol <NSObject>

- (void)videoCompletedDownloading:(NSString*)string;
- (void)videoFailedDownloading:(NSString*)string;
- (void)reachabilityChanged:(NSString*)string;

@end

@interface Server : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) HTTPServer *httpServer;
@property (nonatomic, strong) NSURL *cachePath;

- (void)setup;
- (void)teardown;

- (void)cacheVideo:(NSDictionary*)cacheInfo;

@end


#endif /* Server_h */
