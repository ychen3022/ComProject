//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
// 
// 	MIT License
// 
// 	Permission is hereby granted, free of charge, to any person obtaining
// 	a copy of this software and associated documentation files (the
// 	"Software"), to deal in the Software without restriction, including
// 	without limitation the rights to use, copy, modify, merge, publish,
// 	distribute, sublicense, and/or sell copies of the Software, and to
// 	permit persons to whom the Software is furnished to do so, subject to
// 	the following conditions:
// 
// 	The above copyright notice and this permission notice shall be
// 	included in all copies or substantial portions of the Software.
// 
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// 	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// 	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// 	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// 	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "AESCrypt.h"

#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

@implementation AESCrypt

+(NSString* )base64Encrypt:(NSString* )key
{
    int num1=arc4random() % 20;
    int num2=arc4random() % 20;
    
    char front[num1];
    char below[num2];
    
    for (int i=0; i<num1; i++) {
      front[i]= (char )('1'+arc4random_uniform(42));
    }
    for (int i=0; i<num2; i++) {
        below[i]= (char )('1'+arc4random_uniform(42));
    }
    NSString *frontString = [[NSString alloc] initWithBytes:front length:num1 encoding:NSUTF8StringEncoding];
    NSString *belowString = [[NSString alloc] initWithBytes:below length:num2 encoding:NSUTF8StringEncoding];
    NSData *encryptedData = [key dataUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@0X111%@0X111%@",frontString,[NSString base64StringFromData:encryptedData length:[encryptedData length]],belowString];
}

+(NSString* )base64Decrypt:(NSString* )key
{
    NSArray* array=[key componentsSeparatedByString:@"0X111"];
    if ([array count]==3) {
        NSData *encryptedData = [NSData base64DataFromString:[array objectAtIndex:1]];
        return [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    }else
    {
        return @"";
    }
}

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password {
  NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
  NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
  return base64EncodedString;
}

+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password {
  NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
  NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
  return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

@end



#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Encrypt)
-(NSString *)SHA265:(int)len{
    unsigned char hashedChars[len];
    CC_SHA256([self UTF8String],
              [self lengthOfBytesUsingEncoding:NSASCIIStringEncoding ],
              hashedChars);
    NSData * hashedData = [NSData dataWithBytes:hashedChars length:len];
    
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    return [[[hashedData description] stringByTrimmingCharactersInSet:charsToRemove] stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
