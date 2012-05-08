//
//  User.h
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Course;

extern NSString *const ATRoleStudent;
extern NSString *const ATRoleTeacher;
extern NSString *const ATRoleAdmin;

extern NSString *const ATUserStatusActive;
extern NSString *const ATUserStatusInactive;

@interface User : NSObject

@property(nonatomic, readonly, copy) NSString *userRole;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *lastName;
@property(nonatomic, copy) NSString *userEmail;

//@property(nonatomic, copy) NSArray *userCourses;
@property(nonatomic, copy) NSArray *userMessages;

// create user with role (done)
// override init (done)
+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role;

-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role;
// override description

// create dictionary with user
-(NSDictionary*)saveUserAsDictionary;

-(void) addCourseToUser:(Course*) course;

-(NSArray*) allCourseEvents;
    


@end
