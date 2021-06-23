//
//  NSDictionary+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSDictionary+ConventKit.h"

@implementation NSDictionary (ConventKit)

/*
 * Initialize a NSDictionary from a plist file
 * - param  plistName: plist file name
 * @return None
 */
+ (NSDictionary *)dictFromBundlePlist:(NSString *)plistName {
    NSAssert([plistName length] > 0, @"Plist file name should not empty");
    NSAssert([plistName length] > 0, @"plistName should not empty");
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:plistName];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

/*
 * Initialize an NSDictionary from a given relative path in user document directory
 * @param  relPath: plist file path
 * @return     None
 */
+ (NSDictionary *)dictFromDocumentPlistString:(NSString *)relPath {
    NSAssert([relPath length] > 0, @"plist path should not empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [docPath stringByAppendingPathComponent:relPath];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@end
