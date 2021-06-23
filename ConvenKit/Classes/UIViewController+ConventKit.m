//
//  UIViewController+ConventKit.m
//  PlaneSearch
//
//  Created by Enix Yu on 17/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIViewController+ConventKit.h"

@implementation UIViewController (ConventKit)

- (void)showTabbar:(BOOL)animated {
    if (self.tabBarController == nil || [[self.tabBarController tabBar] isHidden] == NO) {
        return;
    }
    
    UIView *contentView = self.view;
//    if ([[[[self.tabBarController view] subviews] objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
//        contentView = [[[self.tabBarController view ] subviews] objectAtIndex:1];
//    } else {
//        contentView = [[[self.tabBarController view ] subviews] objectAtIndex:0];
//    }
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) - [[self.tabBarController tabBar] frame].size.height);
            [[self.tabBarController tabBar] setHidden:NO];
        }];
    } else {
        contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) - [[self.tabBarController tabBar] frame].size.height);
        [[self.tabBarController tabBar] setHidden:NO];
    }
}

- (void)hideTabbar:(BOOL)animated {
    if (self.tabBarController == nil || [[self.tabBarController tabBar] isHidden] == YES) {
        return;
    }
    
    UIView *contentView = self.view;
//    if ([[[[self.tabBarController view] subviews] objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
//        contentView = [[[self.tabBarController view ] subviews] objectAtIndex:1];
//    } else {
//        contentView = [[[self.tabBarController view ] subviews] objectAtIndex:0];
//    }
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) + [[self.tabBarController tabBar] frame].size.height);
            [[self.tabBarController tabBar] setHidden:YES];
        }];
    } else {
        contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) + [[self.tabBarController tabBar] frame].size.height);
        [[self.tabBarController tabBar] setHidden:YES];
    }
}

@end
