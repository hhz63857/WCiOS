//
//  NetworkCallContext.h
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkCallContext <NSObject>
-(void)postCall:(id)data;
-(id)getUId;
-(id)getURL;
-(id)getPostData;

@end
