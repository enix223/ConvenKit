//
//  UINavigationBar+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 19/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UINavigationBar+ConventKit.h"
#import <objc/runtime.h>

@implementation UINavigationBar (ConventKit)

static char overlayKey;

- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ck_setBackgroundColor:(UIColor *)color{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = color;
}

@end
