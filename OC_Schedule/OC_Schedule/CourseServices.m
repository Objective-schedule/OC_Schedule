//
//  CourseServices.m
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseServices.h"

@implementation CourseServices

-(NSDictionary*)dictionaryFromDbJson:(NSString*)dbId {
    NSMutableDictionary *courseDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithcourseId = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/bycourseid?key=%%22%@%%22" , dbId];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithcourseId];
    //NSLog(@"urlAsString: %@", urlAsString);
    //[urlAsString setString:@"http://127.0.0.1:5984/schema/"];
    //[urlAsString appendString:dbId];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    //NSLog(@"url :%@", url);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&requestError];
    /* Return Value
     The downloaded data for the URL request. Returns nil if a connection could not be created or if the download fails.
     */
    if (response == nil) {
        // Check for problems
        if (requestError != nil) {
            //
            NSLog(@"something is wrong");
            
        }
    }
    else {
        // Data was received.. continue processing
        //NSLog(@"response: %lu", [response length]);
        NSData *data = [NSData dataWithData:response];
        courseDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                         options:NSJSONReadingMutableContainers 
                                                           error:NULL];
        
        NSArray *arr = [courseDictionary  valueForKey:@"rows"];
        courseDictionary = [[arr objectAtIndex:0] objectForKey:@"value"];
        //NSLog(@"dictionary:%@", userDictionary);
        
        
    }
    //NSLog(@"dictionary: %@", userDictionary);
    return courseDictionary;
    
}

@end
