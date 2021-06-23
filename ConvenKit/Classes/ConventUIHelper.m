//
//  ConventUIHelper.m
//  HeartBeat
//
//  Created by Enix Yu on 1/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "ConventUIHelper.h"

@implementation ConventUIHelper

+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (void)setStatusBarForegroundColor:(UIColor *)color{
    
}

@end
