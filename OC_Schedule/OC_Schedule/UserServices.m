
#import "UserServices.h"

@implementation UserServices

-(NSDictionary*)dictionaryFromDbJson:(NSString*)dbId {
    
    NSMutableDictionary *userDictionary = [NSMutableDictionary dictionary];
    // db adress can be put in a constant variable
    NSString *urlWithEmail = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/byemail?key=%%22%@%%22" , dbId];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithEmail];

    
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
    userDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                options:NSJSONReadingMutableContainers 
                                                                        error:NULL];
     return userDictionary;
    
}
-(NSArray*)dictionaryFromMessageDbJson:(NSString*)dbId {
    
    NSArray *messageArray = [NSArray array];
    NSMutableDictionary *userDictionary = [NSMutableDictionary dictionary];

    NSString *urlWithEmail = [NSString stringWithFormat:@"http://127.0.0.1:5984/schedule/_design/views/_view/bymessages?key=%%22%@%%22" , dbId];  
    
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:urlWithEmail];
    
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
    userDictionary = [NSJSONSerialization JSONObjectWithData:data 
                                                         options:NSJSONReadingMutableContainers 
                                                           error:NULL];
        
    messageArray = [userDictionary  valueForKey:@"rows"];

    return messageArray;
    
}

@end
