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

//@property(nonatomic, copy) NSArray *userCourses;
//@property(nonatomic, copy) NSArray *userMessages;

// create user with role (done)
// override init (done)
+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status userMessages:(NSMutableArray*)userMessages;

-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status userMessages:(NSMutableArray*)userMessages;
// override description

// create dictionary with user
-(NSDictionary*)saveUserAsDictionary;
+(id)userFromDictionaryWithMessages: (NSDictionary*)dictionaryWithMessages;
-(NSDictionary*)updateUserAsDictionary;
-(void)updateUser;
+(id)userFromDictionaryWithCourses:(NSDictionary*)dictionaryWithCourses;

-(void) addCourseToUser:(Course*) course; 
-(void) addMessageToUser:(Message*) message;
-(void)addMessage:(NSString*)messageId;
-(NSArray*)getCoursesIds;
-(NSArray*)getMessagesIds;

-(NSArray*) allCourseEvents;

-(NSArray*) dailySchema:(NSDate*) dateToShow;

-(NSArray*) weeklySchema:(NSInteger) weekNum;

-(void) dailyInstructions:(NSDate*) dateToShow;
-(void) weeklyInstructions:(NSInteger) weekNum;

+(id) userFromDictionary:(NSDictionary*) dictionary;

@end
