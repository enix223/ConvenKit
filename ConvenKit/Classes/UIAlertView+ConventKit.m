//
//  UIAlertView+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 1/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIAlertView+ConventKit.h"

@implementation UIAlertView (ConventKit)

+ (void)showAlert:(NSString *)title
          message:(NSString *)message
  cancelBtnString:(nullable NSString *)cancelBtnString{
    if (cancelBtnString == nil) {
        cancelBtnString = NSLocalizedString(@"OK", @"");
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title, title)
                                                    message:NSLocalizedString(message, message)
                                                   delegate:nil
                                          cancelButtonTitle:cancelBtnString
                                          otherButtonTitles:nil];
    [alert show];
}

@end
