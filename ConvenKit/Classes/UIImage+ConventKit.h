//
//  UIImage+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 4/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ConventKit)

+ (UIImage *)imageCompressWithSimple:(UIImage *)image scaledToSize:(CGSize)size;

+ (UIImage *)imageCompressWithSimple:(UIImage *)image scale:(float)scale;

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;

+ (UIImage *)imageFromColor:(UIColor *)color;

/// Convert to base64 string
- (nullable NSString *)base64StringWithHeader:(BOOL)includeHeader PNGFormat:(BOOL)PNGFormat;

@end

NS_ASSUME_NONNULL_END
