//
//  MainApp.h
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User, Course, CourseEvent, CourseServices, Services;

@interface MainApp : NSObject

//*NSArray *allStudents
@property User *activeUser;
@property User *tempUser;
@property Course *tempCourses;


-(void) initApp;
//-(void) initMenu;

-(void)loadUserData:(NSString*) userid;
-(void)loadCourseData:(NSString*) courseid;
-(void)loadAllData;
-(void)checkLogin:(NSString* ) userid;
-(void) adminMenu;
-(void) adminCourseMenu;
-(void) studentMenu;

-(User*) thisActiveUser;
-(void)newStudent;
-(void)newMessage;
-(void)newCourse;
-(NSDate*) requestEventDate;
-(NSString*) requestUserInputText:(NSString*) textToUser;
-(void)newCourseEvent:(Course*)activeCourse;
-(void)addStudentToCourse:(Course*)activeCourse;
//-(void)addCourseToStudent:(User*)student;
-(NSArray*)listAllCoursesSortedByName;
-(NSArray*)listAllStudentsSortedByName;
-(void)studentMessages;

@end
