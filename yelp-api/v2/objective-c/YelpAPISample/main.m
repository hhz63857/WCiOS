//
//  main.m
//  YelpAPISample
//

#import <Foundation/Foundation.h>
#import "YPAPISample.h"

/**
 
 This program uses default query terms that are defined in the main method below.
 You can change them at any time by modifying the strings or by changing the command line arguments in the product scheme, as explained below:
 
 You can edit the command line arguments passed to the program by going into Xcode scheme preferences with the shortcut: Cmd + <
 or by going to 'Product' > 'Scheme' > 'Edit Scheme' > 'Arguments'
 
 The default pattern that you have to use is: -term 'the term here' -location 'the location here'
 If no arguments are specified, the program will default to the constants defined in the main method.
 
 Make sure to enter your API credentials in the "NSURLRequest+OAuth.m" file, otherwise none of your requests will work.
 */
int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
    
////        //test regex
//
//        NSString *source = @"<span class=\"hour-range\"><span class=\"nowrap\">5:00 am</span> - <span class=\"nowrap\">1:30 am</span></span<span class=\"nowrap extra open\">Open now</span>";
////        NSString *pattern = @"hour-range.*nowrap\">[\\d:\\d]*</span";
//        NSString *pattern = @"hour-range.*nowrap extra open";
//        NSRange sourceRange = NSMakeRange(0, [source length]);
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
//        NSArray* matches = [regex matchesInString:source options:0 range: sourceRange];
//        NSString *ret = nil;
//        for (NSTextCheckingResult* match in matches) {
//            NSString* matchText = [source substringWithRange:[match range]];
//            NSLog(@"match: %@", matchText);
//            NSRange r = [match range];
//            NSLog(@"group1: %@", [source substringWithRange:r]);
//            ret = [source substringWithRange:r];
//        }
//        
//        return 0;
        
        //main function
        NSString *defaultTerm = @"coffee";
        NSString *defaultLocation = @"3595 Granada Ave, Santa Clara, CA";
        
        //Get the term and location from the command line if there were any, otherwise assign default values.
        NSString *term = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"] ?: defaultTerm;
        NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;
        
        YPAPISample *APISample = [[YPAPISample alloc] init];
        
        dispatch_group_t requestGroup = dispatch_group_create();
        
        dispatch_group_enter(requestGroup);
        __block NSMutableArray *jsonArr = [[NSMutableArray alloc] init];
        __block int count = 20;
        [APISample queryTopBusinessInfoForTerm:term location:location completionHandler:^(NSDictionary *topBusinessJSON, NSError *error) {
            
            if (error) {
                NSLog(@"An error happened during the request: %@", error);
            } else if (topBusinessJSON) {
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:topBusinessJSON
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
                
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [jsonArr addObject:jsonString];
                NSLog(@"Top business info: \n %@", jsonString);
                count--;
                if(count <= 0) {
                    dispatch_group_leave(requestGroup);
                }
            } else {
                NSLog(@"No business was found");
            }
        }];
        
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
        NSLog(@"%@", jsonArr);
        NSLog(@"done");
    }
    
    return 0;
}

