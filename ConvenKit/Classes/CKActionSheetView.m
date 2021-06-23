//
//  CKActionSheetView.m
//  ConvenKit
//
//  Created by Enix Yu on 4/3/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "CKActionSheetView.h"
#import "UIScreen+ConventKit.h"
#import "UIView+ConventKit.h"
#import "UIColor+ConventKit.h"
#import "ConventMacro.h"
#import <NetworkExtension/NetworkExtension.h>

//-------------------------------------------------------------------
#pragma mark - Settings
//-------------------------------------------------------------------

static const CGFloat kCKActionSheetCellHeight       = 50.0;
static const CGFloat kCKActionSheetSectionHeight    = 10.0;

static const CGFloat kCKActionSheetCellImageWidth   = 25.0;
static const CGFloat kCKActionSheetCellImageMargin  = 5.0;

//-------------------------------------------------------------------
#pragma mark - Action sheet cell
//-------------------------------------------------------------------

@interface CKActionSheetViewItemCell : UITableViewCell

@property (nonatomic, strong, nonnull)  UILabel *titleLabel;
@property (nonatomic, strong, nullable) UIImageView *titleIconImageView;

@end

@interface CKActionSheetViewItemCell ()

@property (nonatomic, strong) NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightMarginConstraint;

@end

@implementation CKActionSheetViewItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Setup label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    // Setup icon image view
    _titleIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    CGRect frame = CGRectMake(0, 0, kCKActionSheetCellImageWidth, kCKActionSheetCellImageWidth);
    _titleIconImageView.frame = frame;
    
    [self addSubview:_titleLabel];
    [self addSubview:_titleIconImageView];
    
    // Set the separator line with full width
    // @see http://stackoverflow.com/questions/26519248/how-to-set-the-full-width-of-separator-in-uitableview
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect fittingRect = [_titleLabel.text
                          boundingRectWithSize:_titleLabel.frame.size
                          options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{ NSFontAttributeName:_titleLabel.font }
                          context:nil];
    CGFloat width = fittingRect.size.width;
    CGFloat labelHeight = fittingRect.size.height;
    
    if (_titleIconImageView.image != nil) {
        CGFloat marginLeft = (CGRectGetWidth(self.frame) - kCKActionSheetCellImageWidth + kCKActionSheetCellImageMargin + width)/2;
        _titleLabel.frame = CGRectMake(marginLeft+kCKActionSheetCellImageMargin+kCKActionSheetCellImageWidth,
                                       (kCKActionSheetCellHeight - labelHeight)/2, width, labelHeight);
    } else {
        _titleIconImageView.hidden = YES;
        CGFloat marginLeft = (CGRectGetWidth(self.frame) - width)/2;
        _titleLabel.frame = CGRectMake(marginLeft, (kCKActionSheetCellHeight - labelHeight)/ 2, width, labelHeight);
    }
}

- (void)prepareForReuse {
    [self prepareForReuse];
    
    _titleLabel.text = nil;
    _titleIconImageView.image = nil;
}

@end

//-------------------------------------------------------------------
#pragma mark - Action sheet
//-------------------------------------------------------------------

@interface CKActionSheetView ()<UITableViewDelegate, UITableViewDataSource>

/// Action sheet background view (mask the superview)
@property (nonatomic, strong, nonnull) UIView *maskView;

/// Action table
@property (nonatomic, strong, nonnull) UITableView *tableView;

/// Action titles (NSString)
@property (nonatomic, strong, nonnull) NSArray<NSString *> *titles;

/// Action cell icon (UIImage, can be null)
@property (nonatomic, strong, nullable) NSArray<UIImage *> *titleImages;

/// Callback when user select an action cell
@property (nonatomic, strong, nullable) CKActionSheetViewChooseCallback choiceCallback;

/// Callback when action sheet is disappear
@property (nonatomic, strong, nullable) CKActionSheetViewCloseCallback complete;

@end

@implementation CKActionSheetView

//-------------------------------------------------------------------
#pragma mark - Life cycle
//-------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _maskView.alpha = 0;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(backgroundDidTap:)];
    gesture.numberOfTouchesRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [_maskView addGestureRecognizer:gesture];
    
    /* Create table view */
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectZero
                  style:UITableViewStyleGrouped];
    
    /* Disable scroll */
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithHex:0xf8f8f8 alpha:1.0];
    _tableView.allowsSelection = YES;
    _tableView.allowsMultipleSelection = NO;

    /* Register a cell */
    [_tableView registerClass:[CKActionSheetViewItemCell class]
       forCellReuseIdentifier:@"CKActionSheetViewItemCell"];
    
    [_maskView addSubview:_tableView];
    [self addSubview:_maskView];
}

//-------------------------------------------------------------------
#pragma mark - TableView Data source / delegate
//-------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_titles count];
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return kCKActionSheetSectionHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCKActionSheetCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKActionSheetViewItemCell *cell = [tableView
                                       dequeueReusableCellWithIdentifier:@"CKActionSheetViewItemCell"
                                       forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = [_titles objectAtIndex:indexPath.row];
        if ([_titleImages count] > 0) {
            
            /* Show icon image if provided */
            [cell.titleIconImageView setImage:[_titleImages objectAtIndex:indexPath.row]];
        }
    } else if (indexPath.section == 1) {
        // Cancel button
        cell.titleLabel.text = NSLocalizedString(@"Cancel", @"");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_choiceCallback) _choiceCallback(indexPath.row);
    } else {
        if (_complete) _complete();
    }
    
    [self disappear];
}

//-------------------------------------------------------------------
#pragma mark - Public API
//-------------------------------------------------------------------

- (void)showActionSheetInView:(UIView *)view
                   withTitles:(NSArray<NSString *> *)titles
                  titleImages:(NSArray<UIImage *> *)titleImages
               choiceCallback:(CKActionSheetViewChooseCallback)choiceCallback
                     complete:(CKActionSheetViewCloseCallback)complete
{
    /* Reset the frame for the action sheet components */
    CGRect frame = view.bounds;
    frame.origin.y = CGRectGetHeight(view.frame);
    frame.size.height = kCKActionSheetCellHeight * ([titles count] + 1) + kCKActionSheetSectionHeight + 0.01;
    _tableView.frame = frame;
    
    _maskView.frame = view.bounds;
    self.frame = view.bounds;
    
    /* Save props */
    _titleImages = titleImages;
    _titles = titles;
    _choiceCallback = choiceCallback;
    _complete = complete;
    
    /* Show action sheet */
    [_tableView reloadData];
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect frame = _tableView.frame;
                         frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(_tableView.frame);
                         _tableView.frame = frame;
                         _maskView.alpha = 1.0;
                     } completion:nil];
}

//-------------------------------------------------------------------
#pragma mark - Private API
//-------------------------------------------------------------------

/// Background is tap
- (void)backgroundDidTap:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
    BOOL isOutside = !CGRectContainsPoint(_tableView.frame, point);;
    if (isOutside) {
        if (_complete) _complete();
        [self disappear];
    }
}

/// Hide the action sheet
- (void)disappear {
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect frame = _tableView.frame;
                         frame.origin.y = CGRectGetHeight(self.frame);
                         _tableView.frame = frame;
                         _maskView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
