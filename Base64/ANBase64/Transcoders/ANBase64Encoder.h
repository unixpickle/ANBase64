//
//  ANBase64Encoder.h
//  Base64
//
//  Created by Alex Nichol on 12/31/11.
//  Copyright (c) 2011 Jitsik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANBase64Encoder : NSObject {
    NSData * originalData;
    NSUInteger byteIndex;
    NSUInteger bitIndex;
}

- (id)initWithData:(NSData *)someData;

- (BOOL)isFinished;
- (UInt8)nextShortByte;
- (NSString *)trailingInfo;

- (NSString *)encodeBase64Data;

@end
