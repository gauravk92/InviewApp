//
//  TeardownProtocol.h
//  moneyapp
//
//  Created by Gaurav Khanna on 9/21/16.
//  Copyright © 2016 Inview Technologies Inc. All rights reserved.
//

#ifndef TeardownProtocol_h
#define TeardownProtocol_h

@protocol TeardownProtocol <NSObject>
@required
- (void)setup;
- (void)teardown;

@end


#endif /* TeardownProtocol_h */
