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
{
    NSArray *courseSchedule, *courseStudents;
}

@synthesize courseId = _courseId, courseName = _courseName, coursePoints = _coursePoints, courseTeacher = _courseTeacher, courseDescription = _courseDescription, courseLitterature = _courseLitterature;

+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSUInteger)coursePoints 
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
         coursepoints:(NSUInteger)coursePoints 
        courseteacher:(NSString*) courseTeacher 
    courseLitterature:(NSArray*) courseLitterature
{
    if(self = [super init]) 
    {
        _courseId = [courseId copy];
        _courseName = [courseName copy];
        _courseDescription =[courseDescription copy];
        _coursePoints = coursePoints;
        _courseTeacher = [courseTeacher copy]; //Should be User object
        _courseLitterature = [courseLitterature copy];
        courseSchedule = [NSArray array];
        
            
    }
    return self;
    
}

-(NSInteger) startWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   return [[calendar components: NSWeekCalendarUnit fromDate:[[courseSchedule objectAtIndex:0] eventStartDate]] week]; 
   
}


-(NSInteger) endWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [[calendar components: NSWeekCalendarUnit fromDate:[[courseSchedule lastObject] eventEndDate]] week];
}

-(void) addCourseEvent:(CourseEvent*) newEvent
{
    
        //Init courseSchedule array when needed, instead of in init function?
   NSMutableArray* newArray = [NSMutableArray arrayWithArray:courseSchedule];
       
   [newArray addObject:newEvent];
    
   NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
   
    //Sort array  
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"eventStartDate" ascending:TRUE];
    NSArray *sortDecArray = [NSArray arrayWithObject:sortDesc];
       
   courseSchedule = [newArray sortedArrayUsingDescriptors:sortDecArray];
            
}

-(NSDictionary*) asDictionary
{   
    
    NSArray* courseEvents = [NSArray  arrayWithArray:[self getEventsAsDictionarys]];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                                self.courseId, @"courseId",
                                               self.courseName, @"courseName",
                    [NSNumber numberWithInt:self.coursePoints], @"coursePoints",
                                       self.courseLitterature, @"courseLitterature",
                                           self.courseTeacher, @"courseTeacher",
                                       self.courseDescription, @"courseDescription", 
                                        courseEvents, @"courseSchema", nil];
                                    //Studentlist should be added
    return data;
    
}

-(NSArray*)getEventsAsDictionarys;
{
     NSMutableArray* eventArray = [NSMutableArray array];
    
    for(CourseEvent *event in courseSchedule)
    {
        [eventArray addObject:[event asDictionary]]; 
    }
    return eventArray;
}

-(void) addStudentToCourse:(User*) user
{
    //Init userCourses array when needed, instead of in init function?
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:courseStudents];
    
    [newArray addObject:user];
    
    courseStudents = newArray;
}

-(NSArray*) allEvents
{
    NSArray *events = [NSArray arrayWithArray:courseSchedule];
    return events;
}

-(NSArray*) allStudents
{
    NSArray *students = [NSArray arrayWithArray:courseStudents];
    return students;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Kursnamn: %@\n KursID: %@\n Kurspoäng: %d\n Kursbeskrivning: %@\n Kurslitteratur: %@\n Kursstart vecka: %d\n Kursslut vecka: %d\n Kurstillfällen: %@" , self.courseName, self.courseId, self.coursePoints, self.courseDescription, self.courseLitterature, [self startWeek], [self endWeek], courseSchedule];
}

@end
