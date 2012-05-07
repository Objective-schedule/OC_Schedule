//
//  Course.m
//  Schedule
//
//  Created by Kenth on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Course.h"
#import "CourseEvent.h"


@implementation Course
//Created by Kenth again....
//Pedro
//Hector

@synthesize courseId = _courseId, courseName = _courseName, coursePoints = _coursePoints, courseTeacher = _courseTeacher, courseDescription = _courseDescription, courseStudents = _courseStudents, courseLitterature = _courseLitterature;

+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSNumber*)coursePoints 
          courseteacher:(NSString*) courseTeacher 
      courseLitterature:(NSArray*) courseLitterature
{

    return [[self alloc] initWithCourseId:courseId coursename:courseName coursedescription:courseDescription coursepoints:coursePoints courseteacher:courseTeacher courseLitterature:courseLitterature];
    
}

-(id)init
{
    return [self initWithCourseId:@"no-courseId" coursename:@"no-courseName" coursedescription:@"no description" coursepoints:0 courseteacher:@"No-teacher" courseLitterature:NULL];
}

-(id)initWithCourseId:(NSString*)courseId 
           coursename:(NSString*)courseName 
    coursedescription:(NSString*)courseDescription 
         coursepoints:(NSNumber*)coursePoints 
        courseteacher:(NSString*) courseTeacher 
    courseLitterature:(NSArray*) courseLitterature
{
    if(self = [super init]) 
    {
        _courseId = [courseId copy];
        _courseName = [courseName copy];
        _courseDescription =[courseDescription copy];
        _coursePoints = [coursePoints copy];
        _courseTeacher = [courseTeacher copy]; //Should be User object
        _courseLitterature = [courseLitterature copy];
            
    }
    return self;
    
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Kursnamn: %@\n KursID: %@\n Kurspoäng: %@\n Kursbeskrivning: %@\n Kurslitteratur: %@", self.courseName, self.courseId, self.coursePoints, self.courseDescription, self.courseLitterature];
}

+(void) addCourseEvent:(CourseEvent*) newEvent
{

    if(!courseSchedule)
    {
        NSArray* courseSchedule = [NSArray arrayWithObject:newEvent]; 
    }
    else 
    {
        NSMutableArray* newArray = [NSMutableArray arrayWithArray:courseSchedule];
        
        [newArray addObject:newEvent];
        
        //Sort array?        
             courseSchedule = newArray;
            
    }

}


@end
