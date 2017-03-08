//
//  singleton.h
//  Money
//
//  Created by Gaurav Khanna on 7/31/16.
//  Copyright © 2016 In View Ads. All rights reserved.
//

#ifndef singleton_h
#define singleton_h

#if __has_feature(objc_arc)

#define MAKE_SINGLETON(class_name, shared_method_name) \
+ (instancetype)shared_method_name { \
static dispatch_once_t pred; \
static class_name * z ## class_name ## _ = nil; \
dispatch_once(&pred, ^{ \
z ## class_name ## _ = [[self alloc] init]; \
}); \
return z ## class_name ## _; \
} \
- (id)copy { \
return self; \
}
#else

#define MAKE_SINGLETON(class_name, shared_method_name) \
+ (instancetype)shared_method_name { \
static dispatch_once_t pred; \
static class_name * z ## class_name ## _ = nil; \
dispatch_once(&pred, ^{ \
z ## class_name ## _ = [[self alloc] init]; \
}); \
return z ## class_name ## _; \
} \
- (id)copy { \
return self; \
} \
- (instancetype)retain { \
return self; \
} \
- (NSUInteger)retainCount { \
return UINT_MAX; \
} \
- (oneway void)release { \
} \
- (instancetype)autorelease { \
return self; \
}
#endif

#endif /* singleton_h */
