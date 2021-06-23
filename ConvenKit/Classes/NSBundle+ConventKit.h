//
//  NSBundle+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 2/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (ConventKit)

/*
 * Get app short version, eg v1.0.0
 * @param  None
 * @return Short version number string
 */
+ (NSString *)appVersion;

/*
 * Get app name
 * @param  None
 * @return App name
 */
+ (NSString *)appName;

/*
 * Get app build version, eg 1
 * @param  None
 * @return app build number
 */
+ (NSString *)appBuild;

/*
 * Get bundle image url with image name
 * @param   imageName
 * @return  the url for that image
 */
+ (nullable NSURL *)imageUrl:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
