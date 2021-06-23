//
//  UIColor+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ConventKit)

/*
 * Create a UIColor with uint8_t red/green/blue and alpha value
 * @param   red: The red value
 * @param   green: The green value
 * @param   blue: The blue value
 * @param   alpha: The alpha value
 * @return      UIColor object
 */
+ (UIColor *)colorWithDecimalRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha;

/*
 * Create a UIColor with hex string, eg @"0xf1f2f4"
 * @param   colorHex: The hex string for the color
 * @return      UIColor object
 */
+ (UIColor *)colorWithHexString:(NSString *)colorHex alpha:(CGFloat)alpha;

/*
 * Create a UIColor with hex value, eg, 0xf1f2f4
 * @param   colorHex: The hex value for the color
 * @return      UIColor object
 */
+ (UIColor *)colorWithHex:(NSInteger)colorHex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
