
#import "Services.h"

@implementation Services

@synthesize databaseAddress = _databaseAddress;


-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}
-(NSDictionary*)saveToDb:(NSDictionary*)dict {
    
    return [self postData:[self createJsonFromDictionary:dict]];
}

// to do synchronousRequest
-(NSDictionary*)postData:(NSData*)jsonWithUser
{
    NSMutableDictionary *dbDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithId = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/"];
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithId];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:jsonWithUser];
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&requestError];

    NSData *data = [NSData dataWithData:response];
    dbDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                       options:NSJSONReadingMutableContainers 
                                                         error:NULL];
    return dbDictionary;
}

-(NSDictionary*)getAllStudents {
    NSMutableDictionary *allUserDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlAllStudents = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/getallstudents"];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlAllStudents];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&requestError];

    NSData *data = [NSData dataWithData:response];
    allUserDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                            options:NSJSONReadingMutableContainers 
                                                              error:NULL];
    return allUserDictionary;
    
}

-(NSDictionary*)getAllCourses {
    NSMutableDictionary *allCoursesDictionary = [NSMutableDictionary dictionary];
    NSString *urlAllCourses = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/getallcourses"];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlAllCourses];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&requestError];
         
    NSData *data = [NSData dataWithData:response];
    allCoursesDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                               options:NSJSONReadingMutableContainers 
                                                                 error:NULL];
    return allCoursesDictionary;
    
}

-(NSDictionary*)getUniqeDoc:(NSString*) dbId
{
    NSMutableDictionary *dbDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithId = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/%@", dbId];
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithId];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    // set method
    [urlRequest setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&requestError];

    NSData *data = [NSData dataWithData:response];
    dbDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                           options:NSJSONReadingMutableContainers 
                                                             error:NULL];
    return dbDictionary;
}

@end
