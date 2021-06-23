//
//  NSError+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 5/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (ConventKit)

/// Prettify the NSError to `Error occurred: errCode: .., description: ....`
- (NSString *)prettify;

/// Prettify with message `<message>, [Error: <error Desc>(<error code>)]`
- (NSString *)prettifyWithMessage:(NSString *)message;

@end
