//
//  NSString+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConventKit)

/*
 * @brief    Generate a random string with given string length, length must greater thant zero
 * @param    length: The generated random string length
 * @return   A random string
 */
+ (NSString *)randomStringWithLength:(NSInteger)length;

/*
 * Check if the NSString contains numeric characters only
 * @param   None
 * @return      True if the string contains number only, or false if not
 */
- (BOOL)isNumberOnly;

/*
 * Check if the NSString contains ascii char only
 * @param   None
 * @return      True if the string contains ascii char only, or false if not
 */
- (BOOL)isAsciiOnly;

/* 
 * Check if the NSString match the Regular expression string
 * @param   regexpStr : Regular expression string for matching
 * @param   ignoreCase: whether ignore lower/upper case when matching
 * @return      True if the string match the regexp string, or false if not
 */
- (BOOL)isMatchRegExpString:(NSString *)regexpStr ignoreCase:(BOOL)ignoreCase;

/*
 * Calculate MD5 for current string
 * @param  None
 * @return MD5 string
 */
- (NSString *)md5;

/*
 * Calculate SHA1 encode string for current string
 * @param    None
 * @return   SHA1 string
 */
- (NSString *)sha1;

/*
 * Calculate Check if it is a mobile number
 * @param    None
 * @return   Yes if mobile number, NO if not 
 */
- (BOOL)isMobileNumber;

@end
