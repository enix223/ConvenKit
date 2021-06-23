//
//  UIAlertView+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 1/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (ConventKit)


/*
 * Show an alert with specified title, message and cancel button string (all strings are localized)
 * @param: title:  The title of the alert
 * @param: message: The body of the alert
 * @param: cancelBtnString: The cancel button string (if null, default to `@"OK"`
 * @return:    None
 */
+ (void)showAlert:(NSString *)title
          message:(NSString *)message
  cancelBtnString:(nullable NSString *)cancelBtnString;

@end

NS_ASSUME_NONNULL_END
