//
//  NSBundle+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 2/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSBundle+ConventKit.h"

@implementation NSBundle (ConventKit)

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)appBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSURL *)imageUrl:(NSString *)imageName {
    return [[NSBundle mainBundle] URLForResource:imageName withExtension:@"png"];
}

@end
