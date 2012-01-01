//
//  ANBase64Decoder.m
//  Base64
//
//  Created by Alex Nichol on 1/1/12.
//  Copyright (c) 2012 Jitsik. All rights reserved.
//

#import "ANBase64Decoder.h"

@implementation ANBase64Decoder

- (id)initWithBase64String:(NSString *)base64 {
    if ((self = [super init])) {
        encodedString = base64;
        if ([base64 hasSuffix:@"="]) {
            if ([base64 hasSuffix:@"=="]) {
                // data padding length = 2
                encodedLength = [base64 length] - 2;
            } else {
                // data padding length = 1
                encodedLength = [base64 length] - 1;
            }
        } else {
            encodedLength = [base64 length];
        }
        dataLength = (encodedLength / 4) * 3;
        if (encodedLength % 4 == 2) dataLength += 1;
        else if (encodedLength % 4 == 3) dataLength += 2;
    }
    return self;
}

- (NSUInteger)dataLength {
    return dataLength;
}

- (BOOL)isFinished {
    if (currentCharIndex >= encodedLength) return YES;
    return NO;
}

- (UInt8)shortByteForChar:(char)aChar {
    const char * charTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    for (int i = 0; i < strlen(charTable); i++) {
        if (charTable[i] == aChar) return i;
    }
    return 0;
}

- (UInt8)readNextByte {
    if ([self isFinished]) return 0;
    char currentChar = (char)[encodedString characterAtIndex:currentCharIndex];
    UInt8 currentCharValue = [self shortByteForChar:currentChar];
    UInt8 retByte = 0;
    for (int i = 0; i < 8; i++) {
        UInt8 retMask = (1 << (7 - i));
        UInt8 curMask = (1 << (5 - currentBitIndex));
        if ((currentCharValue & curMask) != 0) {
            retByte |= retMask;
        }
        
        currentBitIndex += 1;
        if (currentBitIndex == 6) {
            currentCharIndex += 1;
            currentBitIndex = 0;
            if ([self isFinished]) break;
            currentChar = (char)[encodedString characterAtIndex:currentCharIndex];
            currentCharValue = [self shortByteForChar:currentChar];
        }
    }
    return retByte;
}

- (NSData *)readAllBytes {
    UInt8 * bytes = (UInt8 *)malloc(dataLength);
    NSUInteger index = 0;
    while (![self isFinished] && index < dataLength) {
        bytes[index++] = [self readNextByte];
    }
    return [NSData dataWithBytesNoCopy:bytes length:dataLength freeWhenDone:index];
}

@end
