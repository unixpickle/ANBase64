//
//  ANBase64Encoder.m
//  Base64
//
//  Created by Alex Nichol on 12/31/11.
//  Copyright (c) 2011 Jitsik. All rights reserved.
//

#import "ANBase64Encoder.h"

@implementation ANBase64Encoder

- (id)initWithData:(NSData *)someData {
    if ((self = [super init])) {
        originalData = someData;
    }
    return self;
}

- (BOOL)isFinished {
    if (byteIndex >= [originalData length]) return YES;
    return NO;
}

- (UInt8)nextShortByte {
    if ([self isFinished]) return 0;
    UInt8 currentByte = ((const UInt8 *)[originalData bytes])[byteIndex];
    UInt8 retVal = 0;
    UInt8 bitMask = (1 << 5);
    
    for (int i = 0; i < 6; i++) {
        UInt8 checkMask = (1 << (7 - bitIndex));
        if ((currentByte & checkMask) != 0) {
            retVal |= bitMask;
        }
        
        bitMask >>= 1;
        
        bitIndex ++;
        if (bitIndex == 8) {
            byteIndex += 1;
            bitIndex = 0;
            if ([self isFinished]) break;
            currentByte = ((const UInt8 *)[originalData bytes])[byteIndex];
        }
    }
    
    if (bitIndex == 8) {
        byteIndex += 1;
        bitIndex = 0;
    }
    
    return retVal;
}

- (NSString *)trailingInfo {
    switch ([originalData length] % 3) {
        case 0:
            return @"";
            break;
        case 1:
            return @"==";
            break;
        case 2:
            return @"=";
            break;
    }
    return nil;
}

- (NSString *)encodeBase64Data {
    const char * charTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    NSMutableString * encodedString = [[NSMutableString alloc] init];
    
    while (![self isFinished]) {
        UInt8 byteVal = [self nextShortByte];
        [encodedString appendFormat:@"%c", charTable[byteVal]];
    }
    
    [encodedString appendFormat:@"%@", [self trailingInfo]];
    
    return [NSString stringWithString:encodedString];
}

@end
