
#import "CourseServices.h"

@implementation CourseServices

-(NSDictionary*)dictionaryFromDbJson:(NSString*)dbId {
    
    NSMutableDictionary *courseDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithcourseId = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/bycourseid?key=%%22%@%%22" , dbId];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithcourseId];

    
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
    courseDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                         options:NSJSONReadingMutableContainers 
                                                           error:NULL];
        
    NSArray *arr = [courseDictionary  valueForKey:@"rows"];
    courseDictionary = [[arr objectAtIndex:0] objectForKey:@"value"];

    return courseDictionary;
    
}

@end
