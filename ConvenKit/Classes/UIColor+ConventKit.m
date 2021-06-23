//
//  UIColor+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIColor+ConventKit.h"

#define CVC(x)  ((CGFloat)(x)/255)

@implementation UIColor (ConventKit)

+ (UIColor *)colorWithDecimalRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:CVC(red) green:CVC(green) blue:CVC(blue) alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSInteger)colorHex alpha:(CGFloat)alpha {
    NSAssert(colorHex <= 0xffffff && colorHex >= 0x0, @"colorHex should between 0x0 and 0xffffff");
    return [UIColor colorWithDecimalRed:((colorHex & 0xff0000) >> 16)
                                  green:((colorHex & 0x00ff00) >> 8)
                                   blue:(colorHex & 0x0000ff)
                                  alpha:alpha];
}


+ (UIColor *)colorWithHexString:(NSString *)colorHex alpha:(CGFloat)alpha {
    NSString *pattern = @"^#[0-9a-fA-F]{6}$";
    NSError *error;
    unsigned int red, green, blue;
    
    // Check if colorHex correct or not
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if(![regex numberOfMatchesInString:colorHex options:0 range:NSMakeRange(0, [colorHex length])]){
        NSLog(@"Invalid color hex [%@]!", colorHex);
        return [UIColor whiteColor];
    }
    
    // red value
    NSScanner *scanner = [NSScanner scannerWithString:[colorHex substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&red];
    // green value
    scanner = [NSScanner scannerWithString:[colorHex substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&green];
    // blue value
    scanner = [NSScanner scannerWithString:[colorHex substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&blue];
    
    return [UIColor colorWithDecimalRed:red green:green blue:blue alpha:alpha];
}

@end
