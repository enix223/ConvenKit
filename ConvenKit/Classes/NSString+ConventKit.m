//
//  NSString+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSString+ConventKit.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (ConventKit)

- (BOOL)isNumberOnly
{
    NSCharacterSet *_NumericOnly = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isAsciiOnly {
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    if ( [[NSCharacterSet alphanumericCharacterSet] isSupersetOfSet:myStringSet] ) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isMatchRegExpString:(NSString *)regexpStr ignoreCase:(BOOL)ignoreCase{
    NSRegularExpression *regexp;
    if (ignoreCase) {
        regexp = [NSRegularExpression regularExpressionWithPattern:regexpStr options:NSRegularExpressionCaseInsensitive error:nil];
    } else {
        regexp = [NSRegularExpression regularExpressionWithPattern:regexpStr options:kNilOptions error:nil];
    }
    
    NSRange matchResult = [regexp rangeOfFirstMatchInString:self options:kNilOptions range:NSMakeRange(0, [self length])];
    if( matchResult.length > 0 ) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (BOOL)isMobileNumber{
    return [self isMatchRegExpString:@"^1[34578]\\d{9}$" ignoreCase:YES];
}

+ (NSString *)randomStringWithLength:(NSInteger)length {
    NSAssert(length > 0, @"length must greater than 0");
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomStr = [[NSMutableString alloc] initWithCapacity:length];
    for ( int i = 0; i < length; i ++ ) {
        float rand = arc4random_uniform((uint32_t)[letters length]);
        [randomStr appendFormat:@"%@", [letters substringFromIndex:(int)rand]];
    }
    return randomStr;
}

@end
