//
//  SearchWebView.m
//  LocalTest
//
//  Created by Huahan on 4/22/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "SearchWebView.h"

@implementation SearchWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (NSInteger)highlightAllOccurencesOfString:(NSString*)str
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
//    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [self stringByEvaluatingJavaScriptFromString:jsCode];
//    
//    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
//    NSString *ret = [self stringByEvaluatingJavaScriptFromString:startSearch];
//    NSString *result = [self stringByEvaluatingJavaScriptFromString:@"log"];
//    NSString *doc = [self stringByEvaluatingJavaScriptFromString:@"doc"];
//    return [result integerValue];
//}

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str
{
    
    NSString *filePath  = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js" inDirectory:@""];
    NSData *fileData    = [NSData dataWithContentsOfFile:filePath];
    NSString *jsString  = [[NSMutableString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    [self stringByEvaluatingJavaScriptFromString:jsString];
    NSString *startSearch   = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
    NSString *result        = [self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
    return [result integerValue];
}


- (void)removeAllHighlights
{
    [self stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}

@end

