//
//  UIAlertController+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIAlertController+ConventKit.h"

@implementation UIAlertController (ConventKit)

+ (void)showSimpleAlert:(NSString *)title
                message:(NSString *)message inController:(UIViewController *)inController
        cancelButtonString:(nullable NSString *)cancelButtonString
               animated:(BOOL)animated
             completion:(nullable void (^)(void))completion {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, title)
                                                                   message:NSLocalizedString(message, message)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    cancelButtonString = cancelButtonString == nil ? @"OK" : cancelButtonString;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(cancelButtonString, cancelButtonString)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    [inController presentViewController:alert animated:animated completion:completion];
}

+ (void)showSimpleAlert:(NSString *)title
                message:(NSString *)message inController:(UIViewController *)inController
     cancelButtonString:(nullable NSString *)cancelString
               animated:(BOOL)animated
         cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, title)
                                                                   message:NSLocalizedString(message, message)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(cancelString, cancelButtonString)
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelCallback];
    
    [alert addAction:cancelAction];
    [inController presentViewController:alert animated:animated completion:nil];
}


+ (void)showConfirmAlert:(NSString*)title
                 message:(NSString *)message
            inController:(UIViewController *)inController
      cancelButtonString:(NSString *)cancelButtonString
     confirmButtonString:(NSString *)confirmButtonString
          cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback
         confirmCallback:(nullable void (^)(UIAlertAction *))confirmCallback
                animated:(BOOL)animated
              completion:(nullable void (^)())completion {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, title)
                                                                   message:NSLocalizedString(message, message)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(cancelButtonString, cancelButtonString)
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelCallback];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(confirmButtonString, confirmButtonString)
                                                           style:UIAlertActionStyleDefault
                                                         handler:confirmCallback];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [inController presentViewController:alert animated:animated completion:completion];
}

+ (void)showConfirmAlert:(NSString*)title
                 message:(NSString *)message
            inController:(UIViewController *)inController
          cancelCallback:(nullable void (^)(UIAlertAction *))cancelCallback
         confirmCallback:(nullable void (^)(UIAlertAction *))confirmCallback
                animated:(BOOL)animated
              completion:(nullable void (^)())completion {

    [UIAlertController showConfirmAlert:title
                                message:message
                           inController:inController
                     cancelButtonString:@"Cancel"
                    confirmButtonString:@"Confirm"
                         cancelCallback:cancelCallback
                        confirmCallback:confirmCallback
                               animated:animated
                             completion:completion];
}
@end
