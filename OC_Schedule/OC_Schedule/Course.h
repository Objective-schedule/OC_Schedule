//
//  Course.h
//  Schedule
//
//  Created by Kenth on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseEvent.h"

NSArray *courseSchedule;

@interface Course : NSObject

@property(nonatomic, copy) NSString *courseDescription;
@property(nonatomic, copy) NSString *courseName;
@property(nonatomic, copy) NSString *courseId;
@property(nonatomic, copy) NSNumber *coursePoints;
@property(nonatomic, copy) NSString *courseTeacher; //Should be a User instead
@property(nonatomic, copy) NSArray *courseLitterature;
@property(nonatomic, copy) NSDictionary *courseStudents;



+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
        coursedescription:(NSString*)courseDescription 
           coursepoints:(NSNumber*)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature;

-(id)initWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSNumber*)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature;

+(void) addCourseEvent:(CourseEvent*) newEvent;



@end
