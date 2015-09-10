//
//  SigninTask.m
//  LocalTest
//
//  Created by Huahan on 6/13/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "SigninTask.h"
#import "Constant.h"

@implementation SigninTask

NSString *un;
NSString *p;

-(instancetype)initWithUsername:(NSString *)username pwd:(NSString *)pwd
{
    self = [super init];
    if (username && pwd) {
        un = username;
        p = pwd;
        self.url = [NSString stringWithFormat:NW_SING_IN_HTTP_GET_FORMAT, NW_SERVERHOST, NW_SING_IN_PATH, [self _encode:username], [self _encode:pwd]];
    }
    return self;
}

-(NSString *)_encode:(NSString *)str{
    return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)str,
                                                               NULL,
                                                               (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                               kCFStringEncodingUTF8 );
}

- (NSString *)_urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
    return [result autorelease];
}


-(void)postCall:(id)data{
    
}

-(id)getUId{
    return self.url;
}

-(id)getURL{
    return self.url;
}

-(id)getPostData{
    NSString *post = [NSString stringWithFormat:@"username=%@&pwd=%@",
                      [self _urlEncodeValue:un],
                      [self _urlEncodeValue:p]];
    return post;
}
@end
