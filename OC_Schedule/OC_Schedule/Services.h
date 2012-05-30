
#import <Foundation/Foundation.h>
#import "User.h"

@interface Services : NSObject


@property(nonatomic, copy) NSString *databaseAddress;

// create json from dictionary
-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)saveToDb:(NSDictionary*)dict;


// post
-(NSDictionary*)postData:(NSData*)jsonWithUser;
//post a user to db-
-(void)postUserToDb:(NSData*)jsonWithUser;
//post a course to db-
-(void)postCourseToDb:(NSData*)jsonWithCourse;

//get all students
-(NSDictionary*)getAllStudents;
// get all courses
-(NSDictionary*)getAllCourses;
-(NSDictionary*)getUniqeDoc:(NSString*) dbId;

@end
