//
//  NSArray+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSArray+ConventKit.h"

@implementation NSArray (ConventKit)

+ (NSArray *)arrayFromBundlePlist:(NSString *)plistName{
    NSAssert([plistName length] > 0, @"plistName should not empty");
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:plistName];
    return [NSArray arrayWithContentsOfFile:plistPath];
}

+ (NSArray *)arrayFromDocumentPlistString:(NSString *)relPath{
    NSAssert([relPath length] > 0, @"plist path should not empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [docPath stringByAppendingPathComponent:relPath];
    return [NSArray arrayWithContentsOfFile:path];
}

- (id)randomChoice{
    NSUInteger randomIndex = arc4random() % [self count];
    return [self objectAtIndex:randomIndex];
}

- (NSArray *)mapWithBlock:(id (^)(id elem, NSUInteger idx))mapBlock
{
    __block NSMutableArray *mapArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id mapElem = mapBlock(obj, idx);
        [mapArr addObject:mapElem];
    }];
    
    return mapArr;
}

- (NSArray *)filterWithBlock:(BOOL (^)(id elem, NSUInteger idx))filterBlock
{
    __block NSMutableArray *filteredArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (filterBlock(obj, idx)) {
            [filteredArr addObject:obj];
        }
    }];
    
    return filteredArr;
}

@end
