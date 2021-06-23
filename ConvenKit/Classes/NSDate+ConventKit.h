//
//  NSDate+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ConventKit)

/**
 * Convert a date string to a NSDate object with fortmat: @"yyyy-MM-dd HH:mm:ss"
 * @param    dateStr: The date in string format
 * @return       NSDate:  The date of NSDate object
 */
+ (NSDate *)dateFromString:(NSString *)dateStr;

/**
 * Convert a date string in ISO 8601 format(@"yyyy-MM-dd'T'HH:mm:ssZZZZZ") to a NSDate object.
 * @param    dateStr: The date in string format
 * @return       NSDate:  The date of NSDate object
 */
+ (NSDate *)dateFromISO8601String:(NSString *)dateStr;

/**
 * Convert a date string to a NSDate object with fortmat: @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
 * @param    dateStr: The date in string format
 * @return       NSDate:  The date of NSDate object
 */
+ (NSDate *)dateFromUTCString:(NSString *)dateStr;

/**
 * Convert a date string to a NSDate object with fortmat: dateFormat
 * @param    dateStr: The date in string format
 * @param    format:  The format for the dateStr
 * @return       NSDate:  The date of NSDate object
 */
+ (NSDate *)dateFromString:(NSString *)dateStr format:(NSString *)format;

/**
 * Convert a NSDate object to string with fortmat: @"yyyy-MM-dd HH:mm:ss"
 * @return       String:  The date string which representing with specified format
 */
- (NSString *)dateToString;

/**
 * @brief    Convert a NSDate object to string with ISO 8601 format(@"yyyy-MM-dd'T'HH:mm:ssZZZZZ")
 * @return   String:  The date string which representing with specified format
 */
- (NSString *)dateToISO8601String;

/**
 * Convert a NSDate object to string with fortmat: format
 * @param    format:  The format which used for date convert
 * @return       String:  The date string which representing with specified format
 */
- (NSString *)dateToStringWithFormat:(NSString *)format;

/**
 * Convert NSDate object to string with given locale
 * @param  locale, The locale string which used to convert the NSDate object, eg. en-US, zh_CN
 * @return A converted string to represent the date object
 */
- (NSString *)dateToStringWithLocale:(NSString *)localeIdentifier;

/**
 * Convert NSDate object to string with given locale
 * @param  locale: The locale string which used to convert the NSDate object, eg. en-US, zh_CN
 * @param  dateStyle:  The style you need to convert to. Avaiable values, please @see `NSDateFormatterStyle`
 * @return A converted string to represent the date object
 */
- (NSString *)dateToStringWithLocale:(NSString *)localeIdentifier dateStyle:(NSDateFormatterStyle)dateStyle;

/**
 * Convert The year for current NSDate object
 * @return   NSInteger: The year for the current date object
 */
- (NSInteger)year;

/**
 * Convert The month for current NSDate object
 * @return   NSInteger: The month for the current date object
 */
- (NSInteger)month;

/**
 * Convert The day for current NSDate object
 * @return   NSInteger: The day for the current date object
 */
- (NSInteger)day;

/**
 * Get the hour from NDate object
 * @return Hour
 */
- (NSInteger)hour;

/**
 * Get the minue from NDate object
 * @return Hour
 */
- (NSInteger)minue;

/**
 * Get the second from NDate object
 * @return Hour
 */
- (NSInteger)second;

@end

NS_ASSUME_NONNULL_END
