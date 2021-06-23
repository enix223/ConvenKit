//
//  NSUserDefaults+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (ConventKit)


/*
 * Get an object from user default by key
 * @param   key: The key to retrieve the obj
 * @return      An object mapped by the key
 */
+ (nullable id)userDefaultWithKey:(NSString *)key;

/*
 * Save the key, value pair to user default
 * @param  key:   The key for the value
 * @param  value: The value needed to be saved
 * @return     None
 */
+ (void)saveUserDefaultWithKey:(NSString *)key value:(id)value;

/*
 * Remove the value for key `key` in user default
 * @param  key:   The key for the value to be removed
 * @return        None
 */
+ (void)removeUserDefaultForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
