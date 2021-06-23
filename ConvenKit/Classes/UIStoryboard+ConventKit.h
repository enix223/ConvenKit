//
//  UIStoryboard+ConventKit.h
//  HeartBeat
//
//  Created by Enix Yu on 2/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (ConventKit)

/*
 * Init a view controller with identifier `storyboardId` from storyboard with name `storyboardName`
 * @param  storyboardName: The name of the storyboard
 * @param  storyboardId:   The view controller story identifier
 * @return The instance of the view controller
 */
+ (nullable __kindof UIViewController *)initViewControllerWithStoryBoardName:(NSString *)storyboardName
                                                             withId:(NSString *)storyboardId;

/*
 * Init a view controller with identifier `storyboardId` from storyboard `Main`
 * @param  storyboardId:   The view controller story identifier
 * @return The instance of the view controller
 */
+ (nullable __kindof UIViewController *)initViewControllerWithId:(NSString *)storyboardId;

@end

NS_ASSUME_NONNULL_END
