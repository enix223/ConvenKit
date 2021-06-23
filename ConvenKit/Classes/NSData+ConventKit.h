//
//  NSData+ConventKit.h
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ConventKit)

/*
 * @brief   Convert the NSData to NSString, which content is encoded by GBK
 * @return  The NSString in Unicode format
 */
- (NSString *)stringFromGBKEncoding;

/*
 * @brief   Get the CRC32 checksum
 * @return  CRC32 checksum
 */
- (uint32_t)crc32;

/*
 * @brief   Get the CRC16 checksum
 * @return  CRC16 checksum
 */
- (uint16_t)crc16;

/*
 * @brief   Get the CRC8 checksum
 * @return  CRC8 checksum
 */
- (uint8_t)crc8;

@end
