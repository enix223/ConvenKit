//
//  NSData+ConventKit.m
//  ConventKit
//
//  Created by Enix Yu on 30/7/16.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "NSData+ConventKit.h"

#define CRC8INIT 0x00
#define CRC8POLY 0x31 // = X^8+X^5+X^4+X^0

@implementation NSData (ConventKit)

- (NSString *)stringFromGBKEncoding {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:self encoding:enc];
    return str;
}

- (uint32_t)crc32 {
    uint32_t *table = malloc(sizeof(uint32_t) * 256);
    uint32_t crc = 0xffffffff;
    uint8_t *bytes = (uint8_t *)[self bytes];
    
    for (uint32_t i=0; i<256; i++) {
        table[i] = i;
        for (int j=0; j<8; j++) {
            if (table[i] & 1) {
                table[i] = (table[i] >>= 1) ^ 0xedb88320;
            } else {
                table[i] >>= 1;
            }
        }
    }
    
    for (int i=0; i<self.length; i++) {
        crc = (crc >> 8) ^ table[(crc & 0xff) ^ bytes[i]];
    }
    crc ^= 0xffffffff;
    
    free(table);
    return crc;
}

- (uint16_t)crc16 {
    const uint16_t CRC16 = 0x8005;
    uint16_t out = 0;
    int bits_read = 0, bit_flag;
    const uint8_t *data = [self bytes];
    NSUInteger size = [self length];
    
    /* Sanity check: */
    if(data == NULL)
        return 0;
    
    while(size > 0)
    {
        bit_flag = out >> 15;
        
        /* Get next bit: */
        out <<= 1;
        out |= (*data >> bits_read) & 1; // item a) work from the least significant bits
        
        /* Increment bit counter: */
        bits_read++;
        if(bits_read > 7)
        {
            bits_read = 0;
            data++;
            size--;
        }
        
        /* Cycle check: */
        if(bit_flag)
            out ^= CRC16;
        
    }
    
    // item b) "push out" the last 16 bits
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= CRC16;
    }
    
    // item c) reverse the bits
    uint16_t crc = 0;
    i = 0x8000;
    int j = 0x0001;
    for (; i != 0; i >>=1, j <<= 1) {
        if (i & out) crc |= j;
    }
    
    return crc;
}

- (uint8_t)crc8
{
    NSUInteger size = [self length];
    const uint8_t *data = [self bytes];
    
    uint8_t crc, i;
    crc = CRC8INIT;
    
    while (size--)
    {
        crc ^= *data++;
        
        for (i = 0; i < 8; i++)
        {
            if (crc & 0x80) crc = (crc << 1) ^ CRC8POLY;
            else crc <<= 1;
        }
    }
    
    return crc;
}

@end
