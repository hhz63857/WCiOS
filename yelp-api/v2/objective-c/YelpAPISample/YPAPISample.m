//
//  YPAPISample.m
//  YelpAPI

#import "YPAPISample.h"

/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kWebHost           = @"www.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kBusinessWebPath      = @"/biz/";
static NSString * const kSearchLimit       = @"20";

@implementation YPAPISample

#pragma mark - Public

- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
    
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            

            for (NSDictionary * dict in businessArray) {
                NSString *idd = dict[@"id"];
                [self queryBusinessInfoForBusinessIdFromYelpWebpage:idd completionHandler:completionHandler];
            }
            
//            [self queryBusinessInfoForBusinessIds:iddArr completionHandler:completionHandler];

            if ([businessArray count] > 0) {
//                NSDictionary *firstBusiness = [businessArray firstObject];
//                NSString *firstBusinessID = firstBusiness[@"id"];
//                NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
//                
//                [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
            } else {
                completionHandler(nil, error); // No business was found
            }
        } else {
            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
        }
    }] resume];
}

- (void)queryBusinessInfoForBusinessIds:(NSMutableArray *)businessIDs completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    __block NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    for (__block NSString * bid in [businessIDs subarrayWithRange:NSRangeFromString(@"0-1")]) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:bid];
        [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"%@", bid);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (!error && httpResponse.statusCode == 200) {
                NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                jsonDict[bid] = businessResponseJSON;
            } else {
                completionHandler(nil, error);
            }
        }] resume];
    }
    completionHandler(jsonDict, nil);
}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            completionHandler(businessResponseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
    
}

- (void)queryBusinessInfoForBusinessIdFromYelpWebpage:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    NSLog(@"%@", businessID);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoYelpWebpageRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSMutableDictionary * hourRange = [self fetchHourRange:data];
            completionHandler(hourRange, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
}

- (NSMutableDictionary *)fetchHourRange:(NSData *)data {
    
    NSString *dataStr = [NSString stringWithUTF8String:[data bytes]];
    NSString *startPattern = @"hour-range.*</span></span>";
    NSMutableArray *ha = [self regexGetFromString:dataStr WithPattern:startPattern];
    if (ha == nil || [ha count] == 0) {
        return nil;
    }
    NSString *subData = [ha objectAtIndex:0];
    
    NSString *pattern = @"nowrap\">[ :apm\\d]*</span";

    NSMutableArray *haa = [self regexGetFromString:subData WithPattern:pattern];

    NSMutableDictionary * hourRange = [[NSMutableDictionary alloc] init];
    if ([haa count] > 1) {
        hourRange[@"open"] = haa[0];
        hourRange[@"close"] = haa[1];
    }
    return hourRange;
}


-(NSMutableArray *)regexGetFromString:(NSString *)source WithPattern:(NSString *)pattern {
    //test regex
    NSRange sourceRange = NSMakeRange(0, [source length]);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* matches = [regex matchesInString:source options:0 range: sourceRange];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [source substringWithRange:[match range]];
//        NSLog(@"match: %@", matchText);
        NSRange r = [match range];
//        NSLog(@"group1: %@", [source substringWithRange:r]);
        [ret addObject: [source substringWithRange:r]];
    }
    return ret;
}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"limit": kSearchLimit
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}

- (NSURLRequest *)_businessInfoYelpWebpageRequestForID:(NSString *)businessID {
    
    NSString *businessWebPath = [NSString stringWithFormat:@"%@%@", kBusinessWebPath, businessID];
    return [NSURLRequest requestWithHost:kWebHost path:businessWebPath];
}

@end
