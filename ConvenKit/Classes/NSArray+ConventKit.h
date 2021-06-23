//
//  NSArray+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ConventKit)

/* 
 * @brief  Initialize an array from a plist file
 * @param  plistName: plist file name
 * @return None
 */
+ (nullable NSArray *)arrayFromBundlePlist:(NSString *)plistName;

/*
 * Initialize an array from a given relative path in user document directory
 * @param  relPath: plist file path
 * @return     None
 */
+ (nullable NSArray *)arrayFromDocumentPlistString:(NSString *)relPath;

/**
 * @brief  Randomly select an element from the given array
 * @param  None
 * @return A randomly select element
 */
- (id)randomChoice;

/**
 * @brief  Produce a new array of values by mapping each element through a transformation
 *         function (mapBlock).
 * @param  mapBlock  Tranformation function to take the origin element as input and return
 *                   return another element as output
 * @return A new array that each element use mapBlock through transformation 
 */
- (NSArray *)mapWithBlock:(id (^)(id elem, NSUInteger idx))mapBlock;

/**
 * @brief  Iterate each value in the array and return an array with all the element 
 *         pass through the filterBlock test.
 * @param  filterBlock  Filter function to take element and index as parameter and return if the
 *         element should pass the test or not
 * @return A new array with all the elements pass through the filterBlock test
 */
- (NSArray *)filterWithBlock:(BOOL (^)(id elem, NSUInteger idx))filterBlock;

@end

NS_ASSUME_NONNULL_END
