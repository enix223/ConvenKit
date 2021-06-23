//
//  CKAlertView.m
//  ConvenKit
//
//  Created by Enix Yu on 2/3/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "CKAlertView.h"

#import "UIImage+ConventKit.h"
#import "UIColor+ConventKit.h"
#import "UIScreen+ConventKit.h"
#import "UIView+ConventKit.h"

static const CGFloat kAlertWidthFactor = 0.7;
static const CGFloat kAlertTotalHeight = 130;
static const CGFloat kAlertButtonHeight = 45;

static const UInt32  kButtonColor = 0x00BB9C;
static const UInt32  kButtonSelectedBgColor = 0xF0F0F0;
static const UInt32  kButtonNormalBgColor = 0xFFFFFF;

static const UInt32  kDividerColor = 0xF0F0F0;
static const CGFloat kHorizontalDividerWidthFactor = 0.8;
static const CGFloat kVerticalDividerWidthFactor = 0.5;

@interface CKAlertView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) CKAlertActionCallback actionCallback;

@end

@implementation CKAlertView

- (void)showAlert:(NSString *)alertMessage
           inView:(UIView *)view
      cancelTitle:(NSString *)cancelTitle
     confirmTitle:(NSString *)confirmTitle
   actionCallback:(CKAlertActionCallback)actionCallback
{
    _actionCallback = actionCallback;

    //---------------------------------------------------------------------------
    // Message
    //---------------------------------------------------------------------------
    CGFloat totalWidth = [UIScreen screenWidth] * kAlertWidthFactor;
    CGRect frame = CGRectMake(([UIScreen screenWidth] - totalWidth)/2,
                              ([UIScreen screenHeight] - kAlertTotalHeight)/2,
                              totalWidth,
                              kAlertTotalHeight);
    _alertView = [[UIView alloc] initWithFrame:frame];
    _alertView.backgroundColor = [UIColor whiteColor];
    [_alertView setCornerRadius:8.0];
    
    // Allert message
    frame = CGRectMake(0, 0, frame.size.width, kAlertTotalHeight - kAlertButtonHeight);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor colorWithHex:0xCCCCCC alpha:1.0];
    label.text = alertMessage;
    label.font = [UIFont systemFontOfSize:13.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [_alertView addSubview:label];
    
    // Horizontal Separator line
    CAShapeLayer *hdivider = [CAShapeLayer layer];
    hdivider.frame = CGRectMake((totalWidth - totalWidth * kHorizontalDividerWidthFactor)/2, frame.size.height,
                                totalWidth * kHorizontalDividerWidthFactor, 1);
    [hdivider setFillColor:[UIColor colorWithHex:kDividerColor alpha:1.0].CGColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:hdivider.bounds];
    [hdivider setPath:path.CGPath];
    [_alertView.layer addSublayer:hdivider];
    
    //---------------------------------------------------------------------------
    // Buttons
    //---------------------------------------------------------------------------
    
    UIImage *normalImage = [UIImage imageFromColor:[UIColor colorWithHex:kButtonNormalBgColor alpha:1.0]];
    UIImage *selectedImage = [UIImage imageFromColor:[UIColor colorWithHex:kButtonSelectedBgColor alpha:1.0]];
    
    // Cancel button
    frame = CGRectMake(0, frame.size.height, totalWidth/2, kAlertButtonHeight);
    _cancelButton = [[UIButton alloc] initWithFrame:frame];
    [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [_cancelButton setTitleColor:[UIColor colorWithHex:kButtonColor alpha:1.0]
                       forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancelButton];
    
    // Vertical Separator line
    CAShapeLayer *vdivider = [CAShapeLayer layer];
    CGFloat y = kAlertTotalHeight - kAlertButtonHeight + (kAlertButtonHeight * (1 - kVerticalDividerWidthFactor))/2;
    vdivider.frame = CGRectMake(totalWidth/2, y,
                                1, kAlertButtonHeight * kVerticalDividerWidthFactor);
    [vdivider setFillColor:[UIColor colorWithHex:kDividerColor alpha:1.0].CGColor];
    UIBezierPath *vpath = [UIBezierPath bezierPathWithRect:vdivider.bounds];
    [vdivider setPath:vpath.CGPath];
    [_alertView.layer addSublayer:vdivider];
    
    // Confirm Button
    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, totalWidth/2, kAlertButtonHeight);
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = frame;
    [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    [_confirmButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_confirmButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [_confirmButton setTitleColor:[UIColor colorWithHex:kButtonColor alpha:1.0]
                         forState:UIControlStateNormal];
    [_confirmButton addTarget:self
                       action:@selector(confirmDidClicked:)
             forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_confirmButton];
    
    //---------------------------------------------------------------------------
    // Background mask
    //---------------------------------------------------------------------------
    self.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen  screenHeight]);
    _maskView = [[UIView alloc]
                        initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen  screenHeight])];
    _maskView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _maskView.alpha = 0;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(backgroundDidTap:)];
    gesture.numberOfTouchesRequired = 1;
    [_maskView addGestureRecognizer:gesture];
    
    // Show the alert
    [_maskView addSubview:_alertView];
    [self addSubview:_maskView];
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _maskView.alpha = 1.0;
                     } completion:nil];
}

- (void)backgroundDidTap:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
    BOOL isOutside = !CGRectContainsPoint(_alertView.frame, point);;
    if (isOutside) {
        if (_actionCallback) _actionCallback(NO);
        [self disappear];
    }
}

- (void)cancelButtonDidClicked:(id)sender {
    if (_actionCallback) {
        _actionCallback(NO);
    }
    
    [self disappear];
}

- (void)confirmDidClicked:(id)sender {
    if (_actionCallback) {
        _actionCallback(YES);
    }
    
    [self disappear];
}

- (void)disappear {
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _maskView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
