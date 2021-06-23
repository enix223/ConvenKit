//
//  UIAlertController+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (ConventKit)

/*
 * Show a simple alert with @"OK" button (All string is localized)
 * @param    title: The alert title
 * @param    message: The alert message
 * @param    inController: The controller which present the alert
 * @param    cancelButtonString: Cancel button string
 * @param    animated: Show the alert with animation or not
 * @param    completion: The callback when alert is shown
 * @return       None
 */
+ (void)showSimpleAlert:(NSString *)title
                message:(NSString *)message inController:(UIViewController *)inController
     cancelButtonString:(nullable NSString *)cancelString
               animated:(BOOL)animated
             completion:(nullable void (^)(void))completion;


/*
 * Show a simple alert with @"OK" button (All string is localized)
 * @param    title: The alert title
 * @param    message: The alert message
 * @param    inController: The controller which present the alert
 * @param    cancelButtonString: Cancel button string
 * @param    animated: Show the alert with animation or not
 * @param    cancelCallback: The callback when user tap cancel button
 * @return   None
 */
+ (void)showSimpleAlert:(NSString *)title
                message:(NSString *)message inController:(UIViewController *)inController
     cancelButtonString:(nullable NSString *)cancelString
               animated:(BOOL)animated
         cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback;

/*
 * Show a simple alert with custom cancel/confirm buttons (All string is localized)
 * @param    title: The alert title
 * @param    message: The alert message
 * @param    inController: The controller which present the alert
 * @param    cancelButtonString: Cancel button string
 * @param    confirmButtonString: confirm button string
 * @param    cancelCallback: Callback when cancel is tapped
 * @param    confirmCallback: Callback when confirm is tapped
 * @param    animated: Show the alert with animation or not
 * @param    completion: The callback when alert is shown
 * @return       None
 */
+ (void)showConfirmAlert:(NSString*)title
                 message:(NSString *)message
            inController:(UIViewController *)inController
      cancelButtonString:(NSString *)cancelString
     confirmButtonString:(NSString *)confirmString
          cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback
         confirmCallback:(nullable void (^)(UIAlertAction *))confirmCallback
                animated:(BOOL)animated
              completion:(nullable void (^)())completion;

/*
 * Show a simple alert with @"Cancel" and @"Confirm" buttons (All string is localized)
 * @param    title: The alert title
 * @param    message: The alert message
 * @param    inController: The controller which present the alert
 * @param    cancelCallback: Callback when cancel is tapped
 * @param    confirmCallback: Callback when confirm is tapped
 * @param    animated: Show the alert with animation or not
 * @param    completion: The callback when alert is shown
 * @return       None
 */
+ (void)showConfirmAlert:(NSString*)title
                 message:(NSString *)message
            inController:(UIViewController *)inController
          cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback
         confirmCallback:(nullable void (^)(UIAlertAction *))confirmCallback
                animated:(BOOL)animated
              completion:(nullable void (^)())completion;

@end

NS_ASSUME_NONNULL_END
