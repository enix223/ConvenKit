//
//  UIWindow+ConventKit.m
//  Qiange
//
//  Created by Enix Yu on 27/9/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIWindow+ConventKit.h"

@implementation UIWindow (ConventKit)

- (UIViewController *)visibleViewController{
    return [UIWindow getVisibleViewControllerFrom:self.rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc{
    if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *nc = (UINavigationController *)vc;
        return [UIWindow getVisibleViewControllerFrom:nc.visibleViewController];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tc = (UITabBarController *)vc;
        return [UIWindow getVisibleViewControllerFrom:tc.selectedViewController];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
