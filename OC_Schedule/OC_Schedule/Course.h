//
//  Course.h
//  Schedule
//
//  Created by Kenth on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CourseEvent;


@interface Course : NSObject

@property(nonatomic, copy) NSString *courseDescription;
@property(nonatomic, copy) NSString *courseName;
@property(nonatomic, copy) NSString *courseId;
@property(nonatomic) NSUInteger coursePoints;
@property(nonatomic, copy) NSString *courseTeacher; //Should be a User instead
@property(nonatomic, copy) NSArray *courseLitterature;
@property(nonatomic, copy) NSDictionary *courseStudents;
//@property(nonatomic, copy) NSArray *courseSchedule;

// create course (in progress)
// override init (done)
+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
        coursedescription:(NSString*)courseDescription 
           coursepoints:(NSUInteger)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature;

-(id)initWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSUInteger)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature;

<<<<<<< HEAD
// add course event(in progress)
+(void) addCourseEvent:(CourseEvent*) newEvent;
=======

-(void) addCourseEvent:(CourseEvent*) newEvent;
>>>>>>> Course and Course event updatet


// create dictionary with course

// create JSON

// save to db

@end
