//
//  User.h
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Course, CourseEvent, Message;

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
@property(nonatomic, copy) NSString *db_id;
@property(nonatomic, copy) NSString *db_rev;
@property(nonatomic, copy) NSString *status;

+(id) userFromDictionary:(NSDictionary*) dictionary;
+(id)userFromDictionaryWithCourses:(NSDictionary*)dictionaryWithCourses;
+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status;
-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status;
-(NSString*)simpleDescription;
-(NSDictionary*)saveUserAsDictionary;
-(NSDictionary*)updateUserAsDictionary;
-(void)updateUser;
-(void)addCourseToUser:(Course*) course;
-(NSArray*)getCoursesIds;
-(NSArray*)allCourses;
-(void) addMessageToUser:(Message*) message;
-(NSArray*)allCourseEvents;
-(NSArray*)getMessages;
-(NSArray*)dailySchema:(NSDate*) dateToShow;
-(NSArray*) weeklySchema:(NSInteger) weekNum;
-(void)dailyInstructions:(NSDate*) dateToShow;
-(void)weeklyInstructions:(NSInteger) weekNum;


@end
