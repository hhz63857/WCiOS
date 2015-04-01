//
//  LocalDataManager.h
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LocalDataManager : NSObject

-(void) testOnDoc: (UIManagedDocument *)doc;
-(LocalDataManager *) initWithDoc:(UIManagedDocument *)d url:(NSURL *)u;
@end
