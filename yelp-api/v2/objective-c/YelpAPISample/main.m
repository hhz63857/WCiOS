//
//  main.m
//  YelpAPISample
//

#import <Foundation/Foundation.h>
#import "YPAPISample.h"
#import "AppDelegate.h"


/**
 
 This program uses default query terms that are defined in the main method below.
 You can change them at any time by modifying the strings or by changing the command line arguments in the product scheme, as explained below:
 
 You can edit the command line arguments passed to the program by going into Xcode scheme preferences with the shortcut: Cmd + <
 or by going to 'Product' > 'Scheme' > 'Edit Scheme' > 'Arguments'
 
 The default pattern that you have to use is: -term 'the term here' -location 'the location here'
 If no arguments are specified, the program will default to the constants defined in the main method.
 
 Make sure to enter your API credentials in the "NSURLRequest+OAuth.m" file, otherwise none of your requests will work.
 */


int runSample() {
    @autoreleasepool {
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

int test() {
    @autoreleasepool {
        YPAPISample *APISample = [[YPAPISample alloc] init];

        dispatch_group_t requestGroup = dispatch_group_create();
        dispatch_group_enter(requestGroup);
        [APISample testYelpApi:^(NSDictionary *topBusinessJSON, NSError *error) {
            if (error) {
                NSLog(@"An error happened during the request: %@", error);
            } else if (topBusinessJSON) {
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:topBusinessJSON
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"Top business info: \n %@", jsonString);
            } else {
                NSLog(@"No business was found");
            }
            dispatch_group_leave(requestGroup);
        }];
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
    }
    return 0;
}

int testImg(int argc, char * argv[]) {
    
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
}

int main(int argc, const char * argv[]) {
    return runSample();
}
