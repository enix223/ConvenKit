//
//  NSError+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 5/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSError+ConventKit.h"

@implementation NSError (ConventKit)

- (NSString *)prettify{
    return [NSString stringWithFormat:NSLocalizedString(@"Error occurred: code:%ld, reason: %@", @"error"), (long)[self code], [self localizedDescription]];
}

- (NSString *)prettifyWithMessage:(NSString *)message{
    return [NSString stringWithFormat:NSLocalizedString(@"%@, code: %ld, reason: %@", @"error"), message, (long)[self code], [self localizedDescription]];
}

@end
