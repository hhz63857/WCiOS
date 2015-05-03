//
//  SearchWebView.h
//  LocalTest
//
//  Created by Huahan on 4/22/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchWebView : UIWebView
- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

@end
