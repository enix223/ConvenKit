//
//  CKActionSheetView.h
//  ConvenKit
//
//  Created by Enix Yu on 4/3/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKActionSheetView;

typedef void(^CKActionSheetViewChooseCallback)(NSUInteger index);
typedef void(^CKActionSheetViewCloseCallback)(void);

@interface CKActionSheetView : UIView

- (void)showActionSheetInView:(UIView *)view
                   withTitles:(NSArray<NSString *> *)titles
                  titleImages:(NSArray<UIImage *> *)titleImages
               choiceCallback:(CKActionSheetViewChooseCallback)choiceCallback
                     complete:(CKActionSheetViewCloseCallback)complete;

@end
