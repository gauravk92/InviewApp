//
//  ContentViewModel.m
//  moneyapp
//
//  Created by Gaurav Khanna on 9/22/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#import "ContentViewModel.h"

@import Firebase;

@implementation IAContentItem

- (BOOL)isEqualToContentItem:(IAContentItem *)person {
    if (!person) {
        return NO;
    }
    
    BOOL haveEqualURL = (!self.url && !person.url) || [self.url isEqual:person.url];
    BOOL haveEqualType = (!self.isVideo && !person.isVideo) || self.isVideo == person.isVideo;
    
    return haveEqualURL && haveEqualType;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[IAContentItem class]]) {
        return NO;
    }
    
    return [self isEqualToContentItem:(IAContentItem *)object];
}

- (NSUInteger)hash {
    return [self.url hash] ^ [[NSNumber numberWithBool:self.isVideo] hash];
}

@end

@interface ContentViewModel ()

@property (nonatomic, strong) NSMutableArray *content;

@end

@implementation ContentViewModel

- (instancetype)init {
    if ((self = [super init])) {
        _content = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (NSUInteger)nextIndexWithContent:(IAContentItem*)dict {
    if (dict == nil) {
        return 0;
    }
    NSUInteger index = [self.content indexOfObject:dict];
    if (index == NSNotFound) {
        return 0;
    }
    NSUInteger indexPlusOne = index + 1;
    if (indexPlusOne > self.content.count-1) {
        return 0;
    }
    return indexPlusOne;
}

- (IAContentItem*)nextContentWithContent:(IAContentItem *)item {
    if (item) {
        return [self.content objectAtIndex:[self nextIndexWithContent:item]];
    }
    return [self.content objectAtIndex:0];
}

- (void)contentAdded {
    if (self.content.count > 0) {
        [self.delegate viewModelChangedContent:self.content];
    }
}

- (void)updateContent:(NSArray *)array {
    
    [self.content removeAllObjects];
    
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    FIRStorage *storage = [FIRStorage storage];
    
    __weak ContentViewModel *weakSelf = self;
    
    NSMutableArray *shuffled = [NSMutableArray arrayWithArray:array];
    [shuffled shuffle];
    for (NSDictionary *obj in shuffled) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            DLogObject(obj);
            
            NSString *urlString = [obj objectForKey:@"SL"];
            NSString *hash = [urlString sha1];
            NSString *folderPath = [cache stringByAppendingPathComponent:hash];
            NSString *filePath = [folderPath stringByAppendingPathComponent:@"video.mp4"];
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            
            if ([obj objectForKey:@"type"]) {
//                NSString *ext = [obj objectForKey:@"type"];
                NSString *imagePath = [folderPath stringByAppendingPathComponent:@"image"];
                NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
                IAContentItem *item = [IAContentItem new];
                item.url = imageURL;
                item.isVideo = false;
                
//                if ([self.content containsObject:item]) {
//                    
//                    return;
//                }
                
                if ([fm fileExistsAtPath:imagePath]) {
                    
//                    ContentViewModel *strongSelf = weakSelf;
                    
                    [self.content addObject:item];
                    
                    [self contentAdded];
                    
                } else {
                    
                    
                    
                    FIRStorageReference *ref = [storage referenceForURL:urlString];
                    
                    // Create a reference to the file we want to download
                    FIRStorageDownloadTask *downloadTask = [ref writeToFile:imageURL];
                    
                    // Observe changes in status
                    //                [downloadTask observeStatus:FIRStorageTaskStatusResume handler:^(FIRStorageTaskSnapshot *snapshot) {
                    //                    // Download resumed, also fires when the download starts
                    //                }];
                    //
                    //                [downloadTask observeStatus:FIRStorageTaskStatusPause handler:^(FIRStorageTaskSnapshot *snapshot) {
                    //                    // Download paused
                    //                }];
                    //
                    //                [downloadTask observeStatus:FIRStorageTaskStatusProgress handler:^(FIRStorageTaskSnapshot *snapshot) {
                    //                    // Download reported progress
                    //                    double percentComplete = 100.0 * (snapshot.progress.completedUnitCount) / (snapshot.progress.totalUnitCount);
                    //                }];
                    
                    [downloadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
                        // Download completed successfully
                        
                        ContentViewModel *strongSelf = weakSelf;
                        IAContentItem *item = [IAContentItem new];
                        item.url = imageURL;
                        item.isVideo = false;
                        [strongSelf.content addObject:item];
                        
                        [strongSelf contentAdded];
                        
                        NSLog(@"finished downloading: %@", item.url);
                        
                        
                        //                    if (strongSelf.content.count == array.count) {
                        //                        // done
                        //                        [strongSelf.delegate viewModelChangedContent:strongSelf.content];
                        //                    }
                        //
                        
                    }];
                    
                    // Errors only occur in the "Failure" case
                    [downloadTask observeStatus:FIRStorageTaskStatusFailure handler:^(FIRStorageTaskSnapshot *snapshot) {
                        if (snapshot.error != nil) {
                            DLogObject(snapshot.error);
                            switch (snapshot.error.code) {
                                case FIRStorageErrorCodeObjectNotFound: {
                                    // File doesn't exist
                                    break;
                                }
                                case FIRStorageErrorCodeUnauthorized: {
                                    // User doesn't have permission to access file
                                    break;
                                }
                                case FIRStorageErrorCodeCancelled: {
                                    // User canceled the upload
                                    break;
                                }
                                case FIRStorageErrorCodeUnknown: {
                                    // Unknown error occurred, inspect the server response
                                    break;
                                }
                            }
                        }
                    }];
                }
                
                
                
                continue;
            }
            
            IAContentItem *item = [IAContentItem new];
            item.url = fileURL;
            item.isVideo = true;
            
//            if ([self.content containsObject:item]) {
//                
//                return;
//            }
            
            NSLog(@"path: %@", fileURL);
            if ([fm fileExistsAtPath:filePath]) {
                NSLog(@"found file: %@", filePath);
                
                

                [self.content addObject:item];
                
                [self contentAdded];
                
                
//                if (self.content.count == array.count) {
//                    // done
//                    [self.delegate viewModelChangedContent:self.content];
//                }
                
                //
//                NSArray *contents = [fm contentsOfDirectoryAtPath:folderPath error:nil];
//                NSLog(@"contents: %@", contents);
//                if (contents.count < 1) {
//                    for (NSString *contentItem in contents) {
//                        NSLog(@"content item: %@", contentItem);
//                    }
//                } else {
//                    NSError *removeItemErr;
//                    [fm removeItemAtPath:folderPath error:&removeItemErr];
//                    NSLog(@"ERROR: removing folder: %@, %@", folderPath, removeItemErr);
//                }
                
            } else {
                NSLog(@"not found");
//                [fm createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
                NSLog(@"path: %@", folderPath);
                
                FIRStorageReference *ref = [storage referenceForURL:urlString];
                
                // Create a reference to the file we want to download
                FIRStorageDownloadTask *downloadTask = [ref writeToFile:fileURL];
                
                // Observe changes in status
//                [downloadTask observeStatus:FIRStorageTaskStatusResume handler:^(FIRStorageTaskSnapshot *snapshot) {
//                    // Download resumed, also fires when the download starts
//                }];
//                
//                [downloadTask observeStatus:FIRStorageTaskStatusPause handler:^(FIRStorageTaskSnapshot *snapshot) {
//                    // Download paused
//                }];
//                
//                [downloadTask observeStatus:FIRStorageTaskStatusProgress handler:^(FIRStorageTaskSnapshot *snapshot) {
//                    // Download reported progress
//                    double percentComplete = 100.0 * (snapshot.progress.completedUnitCount) / (snapshot.progress.totalUnitCount);
//                }];
                
                [downloadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
                    // Download completed successfully
                    
                    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
                    NSString *tracksKey = @"tracks";
                    
                    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSError *error;
                            AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
                            
                            if (status == AVKeyValueStatusLoaded) {
                                
                                ContentViewModel *strongSelf = weakSelf;
                                IAContentItem *item = [IAContentItem new];
                                item.url = fileURL;
                                item.isVideo = true;
                                [strongSelf.content addObject:item];
                    
                                [strongSelf contentAdded];
                                
                                NSLog(@"finished downloading: %@", item.url);
                                
                                
//                                if (strongSelf.content.count == array.count) {
//                                    // done
//                                    [strongSelf.delegate viewModelChangedContent:strongSelf.content];
//                                }
                            } else {
                                // You should deal with the error appropriately.
                                NSLog(@"obj: %@", obj);
                                NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
                            }
                            //
                            //                            [[NSNotificationCenter defaultCenter]
                            //                             addObserver:self
                            //                             selector:@selector(playerItemDidReachEnd:)
                            //                             name:AVPlayerItemDidPlayToEndTimeNotification
                            //                             object:[self.player currentItem]];
                            
                        });
                    }];
                    
                    
                }];
                
                // Errors only occur in the "Failure" case
                [downloadTask observeStatus:FIRStorageTaskStatusFailure handler:^(FIRStorageTaskSnapshot *snapshot) {
                    if (snapshot.error != nil) {
                        DLogObject(snapshot.error);
                        switch (snapshot.error.code) {
                            case FIRStorageErrorCodeObjectNotFound: {
                                // File doesn't exist
                                break;
                            }
                            case FIRStorageErrorCodeUnauthorized: {
                                // User doesn't have permission to access file
                                break;
                            }
                            case FIRStorageErrorCodeCancelled: {
                                // User canceled the upload
                                break;
                            }
                            case FIRStorageErrorCodeUnknown: {
                                // Unknown error occurred, inspect the server response
                                break;
                            }
                        }
                    }
                }];
                
//                [[FIRStorage storage] referenceForURL: urlString];
                
//                [[FIRStorage storage] referenceForURL: urlString];
                
            }
            
//            FIRStorageReference *storage = [[FIRStorage storage] referenceForURL:];

            
            
//            IAContentItem *item = [IAContentItem new];
//            item.url = [obj objectForKey:@"SL"];
            
            
        } else {
            NSLog(@"ERROR: Expected news content of dictionary type");
        }
    }

}

@end
