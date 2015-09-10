//
//  NetworkService.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService

+ (NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSStringEncoding encoding;
//    NSString *pageData = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:NULL];
//    
//    NSString *es = [NSString stringWithFormat:@"%d", encoding];
//    NSLog(@"url: %@  encoding:%d",url, encoding);
    NSInteger ni = NSUTF8StringEncoding;
    //This IS HACK
//    if ([es intValue] <= 16) { // todo, Fix this hack, change to a validation function
//        ni = [es intValue] % 15;
//    }
    NSString *resultString = [NSString stringWithContentsOfURL:url
                                                      encoding:ni
                                                      error:&error];
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        return nil;
    }
    return resultString;
}

+ (NSDictionary *)parseJSON:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id resultObject = [NSJSONSerialization JSONObjectWithData:data
                        options:kNilOptions error:&error];
    if (resultObject == nil) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    return resultObject;
}

@end
