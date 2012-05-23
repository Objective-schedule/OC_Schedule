//
//  Services.h
//  db
//
//  Created by Student vid Yrkeshögskola C3L on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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

-(void)getAllStudents;
-(NSDictionary*)getUniqeDoc:(NSString*) dbId;

@end
