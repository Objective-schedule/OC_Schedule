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

// create json from dictionary
-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}
-(void)saveToDb:(NSDictionary*)dict {
    [self postUserToDb:[self createJsonFromDictionary:dict]];
    
}
//send user to db



-(void)postUserToDb:(NSData*)jsonWithUser  {
    // db adress can be put in a constant variable
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:@"http://couchdb.webappse.webfactional.com/couchDb/schedule/"];
    
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

-(void)getUniqeDoc:(NSString*) dbId
{
    // db adress can be put in a constant variable
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:@"http://couchdb.webappse.webfactional.com/couchDb/schedule/"];
    
    //[urlAsString setString:@"http://127.0.0.1:5984/schema/"];
    [urlAsString appendString:dbId];
    
    
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

@end
