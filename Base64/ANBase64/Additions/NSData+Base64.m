//
//  NSData+Base64.m
//  Base64
//
//  Created by Alex Nichol on 1/1/12.
//  Copyright (c) 2012 Jitsik. All rights reserved.
//

#import "NSData+Base64.h"

@implementation NSData (Base64)

- (NSString *)base64Representation {
    ANBase64Encoder * encoder = [[ANBase64Encoder alloc] initWithData:self];
    NSString * str = [encoder encodeBase64Data];
    return str;
}

+ (NSData *)dataWithBase64Representation:(NSString *)b64 {
    ANBase64Decoder * decoder = [[ANBase64Decoder alloc] initWithBase64String:b64];
    return [decoder readAllBytes];
}

@end
