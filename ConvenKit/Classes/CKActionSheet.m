//
//  QGActionSheet.m
//  Qiange
//
//  Created by Enix Yu on 20/9/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CKActionSheet.h"
#import "UIScreen+ConventKit.h"
#import "UIColor+ConventKit.h"

static CGFloat QG_ROW_HEIGHT = 60.0;
#define TABBAR_HEIGHT          49

@interface CKActionSheet ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, copy)           NSArray *titles;
@property (nonatomic, nullable, copy) NSArray *icons;
@property (nonatomic, copy)           NSArray<NSDictionary<NSString *, id> *> *userInfo;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, assign) CKActionSheetShowDirection direction;
@property (nonatomic, assign) CGFloat offset;

@end

@implementation CKActionSheet

- (instancetype)initWithItemsTitles:(NSArray<NSString *> *)titles
                              icons:(NSArray<UIImage *> * __nullable)icons
                          direction:(CKActionSheetShowDirection)direction
                            yOffset:(CGFloat)offset
                           userInfo:(nullable NSArray<NSDictionary<NSString *, id> *> *)userInfo {
    self = [super init];
    if (self) {
        NSAssert(icons == nil || icons != nil && [titles count] == [icons count], @"titles array should be of the same size with icons array");
        NSAssert(userInfo == nil || userInfo != nil && [userInfo count] == [titles count], @"userInfo should be with the same size with titles array");
        self.titles = titles;
        self.icons = icons;
        self.direction = direction;
        self.offset = offset;
        self.userInfo = userInfo;
        
        self.rowHeight = (self.rowHeight == 0 ? QG_ROW_HEIGHT : self.rowHeight);
        self.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
        self.backgroundColor = [UIColor colorWithHex:0xf0f0f0 alpha:0.4];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], self.rowHeight * [titles count]) style:UITableViewStylePlain];
        self.tableView.scrollEnabled = NO;
        
        if ( direction == CKActionSheetShowFromTop ) {
            // Show from top
            self.customView = [[UIView alloc] initWithFrame:CGRectMake(0, -[UIScreen screenHeight] + CGRectGetHeight(self.tableView.frame) + offset, [UIScreen screenWidth],  CGRectGetHeight(self.tableView.frame))];
        } else {
            
            // Show from bottom
            self.customView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen screenHeight], [UIScreen screenWidth], CGRectGetHeight(self.tableView.frame))];
        }
        
        self.customView.alpha = 0;
        self.customView.backgroundColor = [UIColor clearColor];
        
        [self.customView addSubview:self.tableView];
        [self addSubview:self.customView];
    }
    return self;
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    UIView *containerView;
    if (view) {
        containerView = view;
    }else{
        containerView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    }
    
    [containerView addSubview:self];
    [self animateDataWithCompletion:completion];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)animateDataWithCompletion:(void (^)(BOOL finished))completion {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[self duration] animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGRect originRect = strongSelf.customView.frame;
        
        if (strongSelf.direction == CKActionSheetShowFromTop) {
            // From top
            originRect.origin.y = strongSelf.offset;
        } else {
            // From bottom
            originRect.origin.y = [UIScreen screenHeight] - CGRectGetHeight(strongSelf.customView.frame) - strongSelf.offset;
        }
        
        strongSelf.customView.alpha = 1;
        strongSelf.customView.frame = originRect;
    } completion:completion];
}

-(void) tappedCancel{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[self duration] animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.alpha = 0;
        CGRect originRect = strongSelf.customView.frame;
        
        if (strongSelf.direction == CKActionSheetShowFromBottom ) {
            originRect.origin.y = [UIScreen screenHeight];
        } else {
            originRect.origin.y = -CGRectGetHeight(strongSelf.tableView.frame);
        }
        
        strongSelf.customView.alpha = 0;
        strongSelf.customView.frame = originRect;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (finished) {
            for (UIView *v in strongSelf.customView.subviews) {
                [v removeFromSuperview];
            }
            [strongSelf.customView removeFromSuperview];
            [strongSelf removeFromSuperview];
            if ([strongSelf.delegate respondsToSelector:@selector(ck_actionSheetDidDismissed:)]) {
                [strongSelf.delegate ck_actionSheetDidDismissed:strongSelf];
            }
            
            if (strongSelf.didDismissedCallback != nil) {
                strongSelf.didDismissedCallback(strongSelf);
            }
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"sheetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[self.titles objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[self itemFont]];
    [cell.imageView setImage:[self.icons objectAtIndex:indexPath.row]];
    
    if (_initialSelectedIndex != nil && [_initialSelectedIndex integerValue] == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(ck_actionSheet:didSelectIndex:userInfo:)]) {
        [self.delegate ck_actionSheet:self didSelectIndex:indexPath.row userInfo:[self.userInfo objectAtIndex:indexPath.row]];
    }
    
    if (_didSelectItemCallback != nil ) {
        _didSelectItemCallback(self, indexPath.row, [_userInfo objectAtIndex:indexPath.row]);
    }

    [self tappedCancel];
}

#pragma mark - UITableViewDelegate

- (UIFont *)itemFont {
    if (_itemFont == nil) {
        return [UIFont systemFontOfSize:14];
    } else {
        return _itemFont;
    }
}

- (void)setRowHeight:(CGFloat)rowHeight {
    if (rowHeight == _rowHeight) {
        return;
    }
    
    _rowHeight = rowHeight;
    CGRect frame = CGRectMake(0, 0, [UIScreen screenWidth], self.rowHeight * [_titles count]);
    self.tableView.frame = frame;
    
    frame = CGRectMake(self.customView.frame.origin.x, self.customView.frame.origin.y, frame.size.width, frame.size.height);
    self.customView.frame = frame;
}

- (NSTimeInterval)duration {
    if (_duration == 0) {
        return 0.4;
    }
    
    return _duration;
}


@end
