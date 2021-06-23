//
//  UIStoryboard+ConventKit.m
//  HeartBeat
//
//  Created by Enix Yu on 2/8/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "UIStoryboard+ConventKit.h"

@implementation UIStoryboard (ConventKit)

+ (nullable __kindof UIViewController *)initViewControllerWithStoryBoardName:(NSString *)storyboardName
                                                             withId:(NSString *)storyboardId{
    return [[UIStoryboard storyboardWithName:storyboardName bundle:nil]
            instantiateViewControllerWithIdentifier:storyboardId];
}

+ (nullable __kindof UIViewController *)initViewControllerWithId:(NSString *)storyboardId{
    return [UIStoryboard initViewControllerWithStoryBoardName:@"Main" withId:storyboardId];
}

@end
