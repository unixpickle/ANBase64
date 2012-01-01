//
//  ANBase64Decoder.h
//  Base64
//
//  Created by Alex Nichol on 1/1/12.
//  Copyright (c) 2012 Jitsik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANBase64Decoder : NSObject {
    NSString * encodedString;
    NSUInteger currentCharIndex;
    NSUInteger currentBitIndex;
    NSUInteger encodedLength;
    NSUInteger dataLength;
}

- (id)initWithBase64String:(NSString *)base64;
- (NSUInteger)dataLength;

- (BOOL)isFinished;
- (UInt8)shortByteForChar:(char)aChar;
- (UInt8)readNextByte;

- (NSData *)readAllBytes;

@end
