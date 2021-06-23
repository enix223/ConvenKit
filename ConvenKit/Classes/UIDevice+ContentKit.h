//
//  UIDevice+ContentKit.h
//  HeartBeat
//
//  Created by Enix Yu on 3/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ContentKit)

/*
 * Get the iOS platform version, eg 9.0
 * @param   None
 * @return  version number
 */
+ (CGFloat)platformVersion;

@end
