//
//  CKAlertView.h
//  ConvenKit
//
//  Created by Enix Yu on 2/3/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CKAlertActionCallback)(BOOL confirm);

NS_ASSUME_NONNULL_BEGIN

@interface CKAlertView : UIView

- (void)showAlert:(NSString *)alertMessage
           inView:(UIView *)view
      cancelTitle:(NSString *)cancelTitle
     confirmTitle:(NSString *)confirmTitle
   actionCallback:(CKAlertActionCallback)actionCallback;

@end

NS_ASSUME_NONNULL_END
