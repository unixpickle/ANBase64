//
//  main.m
//  Base64
//
//  Created by Alex Nichol on 12/31/11.
//  Copyright (c) 2011 Jitsik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBase64Encoder.h"
#import "ANBase64Decoder.h"

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        NSData * strData = [@"the quick brown fox jumps over the lazy dog" dataUsingEncoding:NSASCIIStringEncoding];
        ANBase64Encoder * encoder = [[ANBase64Encoder alloc] initWithData:strData];
        NSString * encoded = [encoder encodeBase64Data];
        ANBase64Decoder * decoder = [[ANBase64Decoder alloc] initWithBase64String:encoded];
        NSData * decoded = [decoder readAllBytes];
        
        NSCAssert([decoded isEqualToData:strData], @"Encode/decode should result in equivalent data.");
        NSLog(@"Encoded: %@", encoded);
        NSLog(@"Decoded: %@", decoded);
    }
    return 0;
}

