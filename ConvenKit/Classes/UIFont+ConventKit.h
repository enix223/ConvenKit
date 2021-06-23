//
//  UIFont+ConventKit.h
//  ConvenKit
//
//  Created by Enix Yu on 10/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//
//  @see: http://stackoverflow.com/questions/14048549/how-to-dynamically-load-a-font-under-ios-for-real
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ConventKit)

#pragma MARK -
#pragma MARK - Register Font

/** 
 * Register UIFont from URI (Asynchronous)
 *
 * @param urlString:   The font URI String you need to load
 * @param completion:  The callback will be called when the font register process is done, if
 *                     register success, success will be equal to YES, and __error__ will set
 *                     to nil; otherwise, __success__ will be set to NO, and the __error__ will
 *                     represent the reason why it failed.
 * @return None
 */
+ (void)registerFontFromURLString:(NSString *)urlString
                       completion:(void (^)(BOOL success, NSString * _Nullable fontName, NSError * _Nullable error))completion;

/**
 * Register UIFont from URI (Asynchronous)
 *
 * @param url:         The font URI you need to load
 * @param completion:  The callback will be called when the font register process is done, if
 *                     register success, success will be equal to YES, and __error__ will set
 *                     to nil; otherwise, __success__ will be set to NO, and the __error__ will
 *                     represent the reason why it failed.
 * @return None
 */
+ (void)registerFontFromURL:(NSURL *)url
                 completion:(void (^)(BOOL success, NSString * _Nullable fontName, NSError *  _Nullable error))completion;

/**
 * Register and return font name with raw font data (Synchronous)
 *
 * @param data:        The font raw data
 * @param error:       NSError poniter for the failure reason, error will only available when
 *                     register process if failed, if success, error will be set to nil
 * @return:            The full font name for the specific font data, nil if convert failed
 */
+ (NSString * _Nullable)registerAndGetFontNameWithRawData:(NSData *)data error:(NSError ** _Nullable )error;

@end

NS_ASSUME_NONNULL_END
