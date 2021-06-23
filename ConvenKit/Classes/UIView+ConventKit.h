//
//  UIView+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ConventKit)

/*
 * Draw left border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @return     None
 */
- (void)setBorderLeftWithWidth:(CGFloat)width borderColor:(UIColor *)color;

/*
 * Draw left border in current UIView with width and border color, and height ratio
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @param  heightRatio: The ratio for the border height (should be between 0.0 ~ 1.0), default is 100%
 * @return     None
 */
- (void)setBorderLeftWithWidth:(CGFloat)width borderColor:(UIColor *)color heightRatio:(CGFloat)ratio;

/*
 * Draw right border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @return     None
 */
- (void)setBorderRightWithWidth:(CGFloat)width borderColor:(UIColor *)color;

/*
 * Draw right border in current UIView with width and border color, and height ratio
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @param  heightRatio: The ratio for the border height (should be between 0.0 ~ 1.0), default is 100%
 * @return     None
 */
- (void)setBorderRightWithWidth:(CGFloat)width borderColor:(UIColor *)color heightRatio:(CGFloat)ratio;

/*
 * Draw top border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @return     None
 */
- (void)setBorderTopWithWidth:(CGFloat)width borderColor:(UIColor *)color;

/*
 * Draw bottom border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @return     None
 */
- (void)setBorderBottomWithWidth:(CGFloat)width borderColor:(UIColor *)color;

/*
 * Draw border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @param  radius: The corner radius for the border
 * @return     None
 */
- (void)setBorderWithWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;

/*
 * Draw shadow in current UIView with given offset, radius, color and opacity
 * @param  offset: The offset for the shadow
 * @param  radius: The corner radius for the shadow
 * @param  color: The color of the shadow
 * @param  opacity: The opacity for the shadow
 * @return     None
 */
- (void)setShadowWithOffset:(CGSize)offset andRadius:(CGFloat)radius andColor:(UIColor *)color opacity:(CGFloat)opacity;

/*
 * Draw outter border in current UIView with width and border color
 * @param  width: The width of the border
 * @param  color: The color of the border
 * @param  radius: The corner radius for the border
 * @return     None
 */
- (void)setOutterBorderWithWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;

/*
 * Set the corner raidus for current view
 * @param  radius: The corner radius for the shadow
 * @return     None
 */
- (void)setCornerRadius:(CGFloat)radius;

/*
 * Set the border color of current view
 * @param  color: The color to be set
 * @return None
 */
- (void)setBorderColor:(UIColor *)borderColor;

/*
 * Set the border width of current view
 * @param  borderWidth: The width of the border
 * @return None
 */
- (void)setBorderWidth:(CGFloat)borderWidth;

/**
 * Set the border shadow of current view
 * @param offset: The shadow offset, x/y offset
 * @param radius: The shadow raidus
 * @param opacity: The shadow opacity value
 * @param color: The shadow color
 * @return None
 */
- (void)setBorderShadowWithOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity color:(UIColor *)color;

/*
 * Lookup the first responder from the view hierarchy
 * @param   None
 * @return      The first responder in the current view
 */
- (UIView *)firstResponder;

@end

@interface UIView (Constraint)

- (void)addConstraintToWidth:(CGFloat)width
              withIdentifier:(NSString * _Nullable)identifier;

- (void)addConstraintToHeight:(CGFloat)height
               withIdentifier:(NSString * _Nullable)identifier;

- (void)addHorizontalCenterConstraintToView:(UIView *)view
                                     offset:(CGFloat)offset
                             withIdentifier:(NSString * _Nullable)identifier;

- (void)addVerticalCenterConstraintToView:(UIView *)view
                                   offset:(CGFloat)offset
                           withIdentifier:(NSString * _Nullable)identifier;

- (void)addHorizontalCenterConstraintToSuperViewWithOffset:(CGFloat)offset
                                            withIdentifier:(NSString * _Nullable)identifier;

- (void)addVerticalCenterConstraintToSuperViewWithOffset:(CGFloat)offset
                                          withIdentifier:(NSString * _Nullable)identifier;

@end

NS_ASSUME_NONNULL_END
