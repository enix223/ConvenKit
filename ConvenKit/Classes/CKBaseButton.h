//
//  CKBaseButton.h
//  ConvenKit
//
//  Created by Enix Yu on 23/1/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CKBaseButtonDisalbeAlpha  0.8

@interface CKBaseButton : UIButton

@property (nonatomic, assign) CGFloat disableAlpha;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) CGFloat cornerRadius;

@end
