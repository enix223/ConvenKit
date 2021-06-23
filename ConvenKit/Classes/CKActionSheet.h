//
//  QGActionSheet.h
//  Qiange
//
//  Created by Enix Yu on 20/9/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CKActionSheet;

typedef NS_ENUM(NSUInteger, CKActionSheetShowDirection) {
    CKActionSheetShowFromTop = 1,
    CKActionSheetShowFromBottom = 0
};

typedef void(^CKActionSheetDidSelectCallback)(CKActionSheet *actionSheet, NSInteger selectedIndex, NSDictionary * __nullable userInfo);
typedef void(^CKActionSheetDidDismissedCallback)(CKActionSheet *actionSheet);

@protocol CKActionSheetDelegate <NSObject>

@optional
- (void)ck_actionSheet:(CKActionSheet *)actionSheet didSelectIndex:(NSInteger)index userInfo:(nullable NSDictionary *)userInfo;
- (void)ck_actionSheetDidDismissed:(CKActionSheet *)actionSheet;

@end

@interface CKActionSheet : UIView

/// Delegate for the action sheet
@property (nonatomic, weak) id<CKActionSheetDelegate> delegate;

/// The titles which will be shown in the action sheet
@property (nonatomic, copy) NSString *title;

/// Customize the row height for the action sheet item
@property (nonatomic, assign) CGFloat rowHeight;

/// Called when the item is selected
@property (nonatomic, strong, nullable) CKActionSheetDidSelectCallback didSelectItemCallback;

/// Called when the action sheet is dismissed
@property (nonatomic, strong, nullable) CKActionSheetDidDismissedCallback didDismissedCallback;

/// The Font for the item label
@property (nonatomic, strong, nullable) UIFont *itemFont;

/// duration for the animation
@property (nonatomic, assign) NSTimeInterval duration;

/// Initial selected item, will show a checkmark if it is set
@property (nonatomic, assign, nullable) NSNumber *initialSelectedIndex;

- (instancetype)initWithItemsTitles:(NSArray<NSString *> *)titles
                              icons:(NSArray<UIImage *> * __nullable)icons
                          direction:(CKActionSheetShowDirection)direction
                            yOffset:(CGFloat)offset
                           userInfo:(nullable NSArray<NSDictionary<NSString *, id> *> *)userInfo;

- (void)showInView:(UIView *)view completion:(nullable void (^)(BOOL finished))completion;

NS_ASSUME_NONNULL_END

@end
