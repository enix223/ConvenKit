//
//  UIImageView+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 3/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ConventKit)

/*
 * Set the current image to round image
 * @param borderWith: The width of the border
 * @param borderColor: The color of the border
 * @return backgroundColor: The color of the background
 */
- (void)roundImageWithBorderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                  backgroundColor:(nullable UIColor *)backgroundColor;

- (void)tintImageColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
