//
//  NSFileManager+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSFileManager+ConventKit.h"

@implementation NSFileManager (ConventKit)

+ (NSArray<NSString *> *)arrayOfFilesInDocPath: (NSString *)relDir {
    NSAssert([relDir length] > 0, @"relative dir should not be empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dir = [docPath stringByAppendingPathComponent:relDir];
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
}

+ (NSArray<NSString *> *)arrayOfFilesInDocPath: (NSString *)relDir filteredByExtention:(NSString *)fileExtension {
    NSAssert([relDir length] > 0, @"relative dir should not be empty");
    NSAssert([fileExtension length] > 0, @"file extension parameter should not be empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dir = [docPath stringByAppendingPathComponent:relDir];
    NSPredicate *filter = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self ENDSWITH '%@'", fileExtension]];
    NSArray *filePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    return [filePaths filteredArrayUsingPredicate:filter];
}

+ (NSString *)absolutePathWithRelPath:(NSString *)relPath{
    NSAssert([relPath length] > 0, @"relpath should not be empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *absPath = [docPath stringByAppendingPathComponent:relPath];
    return absPath;
}

+ (BOOL)createPathIfNotExist:(NSString *)absPath{
    NSAssert([absPath length] > 0, @"absPath should not be empty");
    return [[NSFileManager defaultManager] createDirectoryAtPath:absPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)createPathInDocDirIfNotExist:(NSString *)relPath {
    NSString *absPath = [NSFileManager absolutePathWithRelPath:relPath];
    return [NSFileManager createPathIfNotExist:absPath];
}

+ (NSString *)bundleResourcePath:(NSString *)resouceName{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *resoucePath = [bundlePath stringByAppendingPathComponent:resouceName];
    return resoucePath;
}

+ (BOOL)deleteFileAtPath:(NSString *)absPath{
    NSAssert([absPath length] > 0, @"absPath should not be empty");
    return [[NSFileManager defaultManager] removeItemAtPath:absPath error:nil];
}

+ (BOOL)deleteFileAtDocDirWithPath:(NSString *)relPath{
    NSAssert([relPath length] > 0, @"relPath should not be empty");
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *absPath = [docPath stringByAppendingPathComponent:relPath];
    return [NSFileManager deleteFileAtPath:absPath];
}

@end
