//
//  Course.h
//  Schedule
//
//  Created by Kenth on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CourseEvent;
@class User;

@interface Course : NSObject

@property(nonatomic, copy) NSString *courseDescription;
@property(nonatomic, copy) NSString *courseName;
@property(nonatomic, copy) NSString *courseId;
@property(nonatomic, copy) NSString *db_courseId;
@property(nonatomic, copy) NSString *db_courseRev;



@property(nonatomic, copy) NSString *coursePoints;
@property(nonatomic, copy) NSString *courseTeacher; //Should be a User instead
@property(nonatomic, copy) NSArray *courseLitterature;
//@property(nonatomic, copy) NSDictionary *courseStudents;
//@property(nonatomic, copy) NSArray *courseSchedule;
// test
// create course (in progress)
// override init (done)
//+(id) courseFromDictionary:(NSDictionary*) dictionary;

+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
        coursedescription:(NSString*)courseDescription 
           coursepoints:(NSString*)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature;
           /* db_courseId:(NSString*)db_courseId
           db_courseRev:(NSString*)db_courseRev;*/

-(id)initWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSString*)coursePoints 
          courseteacher:(NSString*) courseTeacher 
    courseLitterature:(NSArray*) courseLitterature;
         /* db_courseId:(NSString*)db_courseId
         db_courseRev:(NSString*)db_courseRev;*/


-(void) addCourseEvent:(CourseEvent*) newEvent;

-(NSInteger) startWeek;
-(NSInteger) endWeek;

-(NSArray*)getEventsAsDictionarys;
-(NSArray*)getStudentsIds;
-(NSDictionary*) asDictionary;

// create dictionary with course

-(void) addStudentToCourse:(User*) user;

-(NSArray*) allEvents;
-(NSArray*) allStudents;

@end
