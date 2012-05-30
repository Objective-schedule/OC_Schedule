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

@property User *activeUser;
@property User *tempUser;
@property Course *tempCourses;


-(void) initApp;
-(void) studentMenu;
-(void)studentMessages;
-(void) adminMenu;
-(void) adminCourseMenu;
-(void)checkLogin:(NSString* ) userid;
-(void)newStudent;
-(void)newMessage;
-(void)newCourse;
-(void)newCourseEvent:(Course*)activeCourse;
-(void)addStudentToCourse:(Course*)activeCourse;
-(void)editCourseEvent:(Course*)activeCourse;
-(NSDate*)requestEventDate;
-(User*) thisActiveUser;
-(NSArray*)listAllCoursesSortedByName;
-(NSArray*)listAllStudentsSortedByName;
-(void) addCourseToAllCourses:(Course*) course;
-(void) addStudentToAllStudents:(User*) student;

@end
