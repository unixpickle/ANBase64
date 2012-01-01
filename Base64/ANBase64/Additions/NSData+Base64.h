//
//  NSData+Base64.h
//  Base64
//
//  Created by Alex Nichol on 1/1/12.
//  Copyright (c) 2012 Jitsik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBase64Decoder.h"
#import "ANBase64Encoder.h"

@interface NSData (Base64)

- (NSString *)base64Representation;
+ (NSData *)dataWithBase64Representation:(NSString *)b64;

@end
