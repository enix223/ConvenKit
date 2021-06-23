//
//  UIView+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+ConventKit.h"

@implementation UIView (ConventKit)

- (void)setBorderLeftWithWidth:(CGFloat)width borderColor:(UIColor *)color
{
    [self setBorderLeftWithWidth:width borderColor:color heightRatio:1.0];
}

- (void)setBorderLeftWithWidth:(CGFloat)width borderColor:(UIColor *)color heightRatio:(CGFloat)ratio {
    NSAssert(ratio >= 0.0 && ratio <= 1.0, @"heightRatio should be in range 0 to 1");
    CALayer *border = [CALayer layer];
    [border setBackgroundColor:color.CGColor];
    CGFloat height = self.frame.size.height * ratio;
    border.frame = CGRectMake(0, (self.frame.size.height - height) / 2, width, height);
    [self.layer addSublayer:border];
}

- (void)setBorderRightWithWidth:(CGFloat)width borderColor:(UIColor *)color
{
    [self setBorderRightWithWidth:width borderColor:color heightRatio:1.0];
}

- (void)setBorderRightWithWidth:(CGFloat)width borderColor:(UIColor *)color heightRatio:(CGFloat)ratio {
    NSAssert(ratio >= 0.0 && ratio <= 1.0, @"heightRatio should be in range 0 to 1");
    CALayer *border = [CALayer layer];
    [border setBackgroundColor:color.CGColor];
    CGFloat height = self.frame.size.height * ratio;
    border.frame = CGRectMake(self.frame.size.width - width, (self.frame.size.height - height) / 2, width, height);
    [self.layer addSublayer:border];
}

- (void)setBorderTopWithWidth:(CGFloat)width borderColor:(UIColor *)color
{
    CALayer *border = [CALayer layer];
    [border setBackgroundColor:color.CGColor];
    border.frame = CGRectMake(0, 0, self.frame.size.width, width);
    [self.layer addSublayer:border];
}

- (void)setBorderBottomWithWidth:(CGFloat)width borderColor:(UIColor *)color
{
    CALayer *border = [CALayer layer];
    [border setBackgroundColor:color.CGColor];
    border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
    [self.layer addSublayer:border];
}

- (void)setBorderWithWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

- (void)setOutterBorderWithWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

- (void)setShadowWithOffset:(CGSize)offset andRadius:(CGFloat)radius andColor:(UIColor *)color opacity:(CGFloat)opacity
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowColor = color.CGColor;
}

- (void)setCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIView *)firstResponder
{
    if ([self isFirstResponder])
    {
        return self;
    }
    
    for (UIView *view in self.subviews)
    {
        UIView *firstResponder= [view firstResponder];
        if (firstResponder)
        {
            return firstResponder;
        }
    }
    
    return nil;
}

- (void)setBorderShadowWithOffset:(CGSize)offset
                           radius:(CGFloat)radius
                          opacity:(CGFloat)opacity
                            color:(UIColor *)color {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
    self.layer.shadowPath = shadowPath.CGPath;
}

@end

@implementation UIView (Constraint)

- (void)addConstraintToWidth:(CGFloat)width withIdentifier:(NSString *)identifier {
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:self
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1.0
                                      constant:width];
    if (identifier != nil) {
        constraint.identifier = identifier;
    }
    
    [self addConstraint:constraint];
}

- (void)addConstraintToHeight:(CGFloat)height withIdentifier:(NSString *)identifier {
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:self
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1.0
                                      constant:height];
    if (identifier != nil) {
        constraint.identifier = identifier;
    }
    
    [self addConstraint:constraint];
}

- (void)addHorizontalCenterConstraintToView:(UIView *)view
                                     offset:(CGFloat)offset
                             withIdentifier:(NSString * _Nullable)identifier {
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:self
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:view
                                      attribute:NSLayoutAttributeCenterX
                                      multiplier:1
                                      constant:offset];
    if (identifier != nil) constraint.identifier = identifier;
    [self addConstraint:constraint];
}

- (void)addVerticalCenterConstraintToView:(UIView *)view
                                   offset:(CGFloat)offset
                           withIdentifier:(NSString * _Nullable)identifier {
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:self
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:view
                                      attribute:NSLayoutAttributeCenterY
                                      multiplier:1
                                      constant:offset];
    if (identifier != nil) constraint.identifier = identifier;
    [self addConstraint:constraint];
}

- (void)addHorizontalCenterConstraintToSuperViewWithOffset:(CGFloat)offset
                                            withIdentifier:(NSString * _Nullable)identifier
{
    [self addHorizontalCenterConstraintToView:self.superview
                                       offset:offset
                               withIdentifier:identifier];
}

- (void)addVerticalCenterConstraintToSuperViewWithOffset:(CGFloat)offset
                                          withIdentifier:(NSString * _Nullable)identifier
{
    [self addVerticalCenterConstraintToView:self.superview
                                     offset:offset
                             withIdentifier:identifier];
}

@end
