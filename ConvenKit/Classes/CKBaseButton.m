//
//  CKBaseButton.m
//  ConvenKit
//
//  Created by Enix Yu on 23/1/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "CKBaseButton.h"

#define MTBaseButtonIndicatoryViewWidth  22

@interface CKBaseButton ()

@property (nonatomic, strong) UIActivityIndicatorView *ind;
@property (nonatomic, copy) NSString *savedTitle;

@end


@implementation CKBaseButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.disableAlpha = CKBaseButtonDisalbeAlpha;
    self.layer.cornerRadius = self.cornerRadius;
}

- (void)setEnabled:(BOOL)enabled
{
    if (enabled) {
        [self setAlpha:1];
    } else {
        [self setAlpha:self.disableAlpha];
    }
    [super setEnabled:enabled];
}

- (void)setLoading:(BOOL)loading
{
    if (_loading != loading) {
        _loading = loading;
        
        if (loading) {
            self.ind = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - MTBaseButtonIndicatoryViewWidth) / 2, (CGRectGetHeight(self.bounds) - MTBaseButtonIndicatoryViewWidth) / 2, MTBaseButtonIndicatoryViewWidth, MTBaseButtonIndicatoryViewWidth)];
            self.enabled = NO;
            self.savedTitle = self.currentTitle;
            [self setTitle:nil forState:UIControlStateDisabled];
            [self addSubview:self.ind];
            [self.ind startAnimating];
        } else {
            [self.ind stopAnimating];
            [self.ind removeFromSuperview];
            self.ind = nil;
            self.enabled = YES;
            [self setTitle:self.savedTitle forState:UIControlStateDisabled];
        }
    }
}

@end