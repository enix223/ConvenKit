//
//  UIDevice+ContentKit.m
//  HeartBeat
//
//  Created by Enix Yu on 3/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIDevice+ContentKit.h"

@implementation UIDevice (ContentKit)

+ (CGFloat)platformVersion {
    return [UIDevice currentDevice].systemVersion.floatValue;
}

@end
