//
//  NSDictionary+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ConventKit)

/*
 * Initialize a NSDictionary from a plist file
 * - param  plistName: plist file name
 * @return None
 */
+ (NSDictionary *)dictFromBundlePlist:(NSString *)plistName;

/*
 * Initialize an NSDictionary from a given relative path in user document directory
 * @param  relPath: plist file path
 * @return     None
 */
+ (NSDictionary *)dictFromDocumentPlistString:(NSString *)relPath;

@end

NS_ASSUME_NONNULL_END
