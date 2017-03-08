//
//  Server.m
//  Money
//
//  Created by Gaurav Khanna on 3/7/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#import "Server.h"

//static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation Server

- (void)startServer
{
    // Start the server (and check for problems)
    
    NSError *error;
    if([self.httpServer start:&error])
    {
        NSLog(@"Started HTTP Server on port %hu", [self.httpServer listeningPort]);
    }
    else
    {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

- (void)teardown {
    
}

- (void)setup {
    NSLog(@"SETTING UP");
    
    __weak Server *weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        NSString *output;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                output = @"Unknown";
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                output = @"NotReachable";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                output = @"WWAN";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                output = @"WiFi";
                break;
            }
        }
        
        [weakSelf.delegate performSelector:@selector(reachabilityChanged:) withObject:output];
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
   [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    self.httpServer = [[HTTPServer alloc] init];
    
    [self.httpServer setType:@"_http._tcp."];
    [self.httpServer setPort:54172];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    self.cachePath = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSString *cachePathString = [paths objectAtIndex:0];
    
    [self.httpServer setDocumentRoot:cachePathString];
    
    [self startServer];
   
}

- (void)cacheVideo:(NSDictionary *)cacheInfo {
    NSString *idString = [cacheInfo objectForKey:@"id"];
    NSString *videoString = [cacheInfo objectForKey:@"url"];
    
    __weak Server *weakSelf = self;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:videoString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [weakSelf.cachePath URLByAppendingPathComponent:idString];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        if (filePath) {
            NSLog(@"filePath: %@", filePath);
            [weakSelf.delegate performSelector:@selector(videoCompletedDownloading:) withObject:cacheInfo];
        } else {
            [weakSelf.delegate performSelector:@selector(videoFailedDownloading:) withObject:cacheInfo];
        }
    }];
    [downloadTask resume];
    
}

@end