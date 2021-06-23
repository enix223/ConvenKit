//
//  UIViewController+ConventKit.h
//  PlaneSearch
//
//  Created by Enix Yu on 17/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ConventKit)

/// Show tabbar if hidden
- (void)showTabbar:(BOOL)animated;

/// Hide tabbar if not hidden
- (void)hideTabbar:(BOOL)animated;

@end
