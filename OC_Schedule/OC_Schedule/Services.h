
#import <Foundation/Foundation.h>
#import "User.h"

@interface Services : NSObject


@property(nonatomic, copy) NSString *databaseAddress;

-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)saveToDb:(NSDictionary*)dict;
-(NSDictionary*)postData:(NSData*)jsonWithUser;
-(NSDictionary*)getAllStudents;
-(NSDictionary*)getAllCourses;
-(NSDictionary*)getUniqeDoc:(NSString*) dbId;


@end
