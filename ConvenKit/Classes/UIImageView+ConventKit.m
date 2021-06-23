//
//  UIImageView+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 3/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIImageView+ConventKit.h"

@implementation UIImageView (ConventKit)

- (void)roundImageWithBorderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                  backgroundColor:(nullable UIColor *)backgroundColor {
    
    self.layer.borderColor  = borderColor.CGColor;
    self.layer.borderWidth  = borderWidth;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.backgroundColor = backgroundColor;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
}

- (void)tintImageColor:(UIColor *)color {
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = color;
}

@end
