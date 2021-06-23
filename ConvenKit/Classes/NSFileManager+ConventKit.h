//
//  NSFileManager+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ConventKit)

/*
 * Get a list of files' path with searching relDir in NSDocumentDirectory directory
 *
 * @param   relDir: The relative path in NSDocument
 * @return      None
 */
+ (NSArray<NSString *> *)arrayOfFilesInDocPath: (NSString *)relDir;

/*
 * Get a list of files' path with searching relDir in NSDocumentDirectory directory, and filtering by file extension: fileExtension.
 *      eg, you can call `[NSFileManager arrayOfFilesInDocPath:@"data" filteredByExtention:@"plist"]` to get a list of plist files under app/DocumentDirectory/data directory.
 *
 * @param     relDir: The relative path in NSDocument
 * @param     fileExtension: The file extension
 * @return      None
 */
+ (NSArray<NSString *> *)arrayOfFilesInDocPath: (NSString *)relDir filteredByExtention:(NSString *)fileExtension;

/*
 * Get the absolute path with given relpath in User document dir
 * @param  relPath: the relative path
 * @return     The full absoulte path
 */
+ (NSString *)absolutePathWithRelPath:(NSString *)relPath;

/**
 * Create dir if not exist
 * @param   absPath  The absolute path
 * @return      YES if created, NO if failed
 */
+ (BOOL)createPathIfNotExist:(NSString *)absPath;

/**
 * Create dir id user document dir if not exist
 * @param   relPath  The relative path in document dir
 * @return      YES if created, NO if failed
 */
+ (BOOL)createPathInDocDirIfNotExist:(NSString *)relPath;

/**
 * Get the resouce path from bundle
 * @param   resouceName  The resouce file name, if file in subfolder,
 *          need to provide the subfolder name in `resouceName`
 * @return  The resouce absolute path
 */
+ (NSString *)bundleResourcePath:(NSString *)resouceName;

/**
 * Delete a file
 * @param   absPath  The absolute path
 * @return  YES if created, NO if failed
 */
+ (BOOL)deleteFileAtPath:(NSString *)absPath;

/**
 * Delete a file in Document dir
 * @param   relPath  The relative path
 * @return  YES if created, NO if failed
 */
+ (BOOL)deleteFileAtDocDirWithPath:(NSString *)relPath;

@end

NS_ASSUME_NONNULL_END
