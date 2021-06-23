//
//  NSDate+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSDate+ConventKit.h"

@implementation NSDate (ConventKit)

#pragma mark - Class methods

+ (NSDate *)dateFromString:(NSString *)dateStr{
    return [NSDate dateFromString:dateStr format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromUTCString:(NSString *)dateStr {
    return [NSDate dateFromString:dateStr format:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
}

+ (NSDate *)dateFromString:(NSString *)dateStr format:(NSString *)format{
    NSAssert([dateStr length] > 0, @"date string should not empty");
    NSAssert([format length] > 0, @"format parameter should not empty");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateStr];
}

+ (NSDate *)dateFromISO8601String:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"];
    NSDate *dt = [dateFormatter dateFromString:dateStr];
    if (dt == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        dt = [dateFormatter dateFromString:dateStr];
    }
    return dt;
}

#pragma mark - Instance methods

- (NSString *)dateToString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSString *)dateToISO8601String {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSString *)dateToStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSString *)dateToStringWithLocale:(NSString *)localeIdentifier {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSAssert(locale != nil, @"provided localeIdentifier is not a valid locale identifier.");
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterLongStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.locale = locale;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSString *)dateToStringWithLocale:(NSString *)localeIdentifier dateStyle:(NSDateFormatterStyle)dateStyle {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSAssert(locale != nil, @"provided localeIdentifier is not a valid locale identifier.");
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.locale = locale;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSInteger)year {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)day {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)hour{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)minue{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)second{
    return [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:self];
}

@end
