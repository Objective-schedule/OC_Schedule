//
//  Services.m
//  db
//
//  Created by Student vid Yrkeshögskola C3L on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Services.h"

@implementation Services

@synthesize databaseAddress = _databaseAddress;

// createJsonFromDictionary , saveToDb, postUserToDb: only admin
// create json from dictionary
-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}
-(void)saveToDb:(NSDictionary*)dict {
    NSLog(@"dictionary from savetodb: %@", dict);
    //[self postUserToDb:[self createJsonFromDictionary:dict]];
    [self postCourseToDb:[self createJsonFromDictionary:dict]];
    
    // take away depending of update or new user, and course(_id, _rev) check if _id is empty
}
//send course to db

-(void)postCourseToDb:(NSData*)jsonWithCourse {
    // db adress can be put in a constant variable
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:@"http://127.0.0.1:5984/schedule/"];
    
    //[urlAsString setString:@"http://127.0.0.1:5984/schema/"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [urlRequest setHTTPBody:jsonWithCourse];
    // send sendAsynchronous
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *urlResponse,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] > 0 && error == NULL){ // do success or error call with true or false
             NSMutableData *incomingData;
             if(!incomingData) {
                 incomingData = [[NSMutableData alloc]init];
             }
             [incomingData appendData:data];
             NSString *string = [[NSString alloc]initWithData:incomingData
                                                     encoding:NSUTF8StringEncoding];
             incomingData = nil;
             //NSLog(@"string has %lu characters", [string length]);
             //NSLog(@"save successfully!!! %@", string);
             NSLog(@"the data: %@", string);
             
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
    
    
    [[NSRunLoop currentRunLoop]run];
}
//send user to db
-(void)postUserToDb:(NSData*)jsonWithUser  {
    // db adress can be put in a constant variable
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:@"http://127.0.0.1:5984/schedule/"];
    
    //[urlAsString setString:@"http://127.0.0.1:5984/schema/"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [urlRequest setHTTPBody:jsonWithUser];
    // send sendAsynchronous
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *urlResponse,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] > 0 && error == NULL){ // do success or error call with true or false
             NSMutableData *incomingData;
             if(!incomingData) {
                 incomingData = [[NSMutableData alloc]init];
             }
             [incomingData appendData:data];
             NSString *string = [[NSString alloc]initWithData:incomingData
                                                     encoding:NSUTF8StringEncoding];
             incomingData = nil;
             //NSLog(@"string has %lu characters", [string length]);
             //NSLog(@"save successfully!!! %@", string);
             // NSLog(@"the data: %@", string);
             
                      }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
     

    [[NSRunLoop currentRunLoop]run];
}
-(void)getAllStudents
{
    // db adress can be put in a constant variable
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:@"http://couchdb.webappse.webfactional.com/couchDb/schedule/"];
    //local couch
    //[urlAsString setString:@"http://127.0.0.1:5984/schema/_design/views/_view/byStudent"];
    
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //[urlRequest setHTTPBody];
    // send sendAsynchronous
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *urlResponse,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] > 0 && error == NULL){ // do success or error call with true or false
             NSMutableData *incomingData;
             if(!incomingData) {
                 incomingData = [[NSMutableData alloc]init];
             }
             [incomingData appendData:data];
             NSString *string = [[NSString alloc]initWithData:incomingData
                                                     encoding:NSUTF8StringEncoding];
             incomingData = nil;
             //NSLog(@"string has %lu characters", [string length]);
             NSLog(@"get successfull!!! %@", string);
             // NSLog(@"the data: %@", string);
             
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
    
    [[NSRunLoop currentRunLoop]run];

}

-(NSDictionary*)getUniqeDoc:(NSString*) dbId
{
    NSMutableDictionary *dbDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithId = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/%@", dbId];
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithId];
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
        dbDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                           options:NSJSONReadingMutableContainers 
                                                             error:NULL];
        
        //NSArray *arr = [dbDictionary  valueForKey:@"rows"];
        //dbDictionary = [[arr objectAtIndex:0] objectForKey:@"value"];
       // NSLog(@"dictionary:%@", dbDictionary);
        
        
    }
    //NSLog(@"uniquedoc dictionary: %@", dbDictionary);
    return dbDictionary;
}

@end
