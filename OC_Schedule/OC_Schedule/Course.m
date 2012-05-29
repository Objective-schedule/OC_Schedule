//
//  Course.m
//  Schedule
//
//  Created by Kenth on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Course.h"
#import "CourseEvent.h"
#import "User.h"
#import "Services.h"
@implementation Course
//Created by Kenth again....
//Pedro
//Hector
{
    NSArray *courseSchedule, *courseStudents;
    Services *service;
}

@synthesize courseId = _courseId, courseName = _courseName, coursePoints = _coursePoints, courseTeacher = _courseTeacher, courseDescription = _courseDescription, courseLitterature = _courseLitterature, db_courseId = _db_courseId, db_courseRev = _db_courseRev;

+(id) courseFromDictionary:(NSDictionary*) dictionary {
    
    return [self courseWithCourseId:[dictionary valueForKey:@"courseId"]
                          coursename:[dictionary valueForKey:@"courseName"]
                          coursedescription:[dictionary valueForKey:@"courseDescription"]
                              coursepoints:[dictionary valueForKey:@"coursePoints"]
                             courseteacher: [dictionary valueForKey:@"courseTeacher"]
                  courseLitterature: [dictionary valueForKey:@"courseLitterature"]
                        db_courseId: [dictionary valueForKey:@"_id"]
                       db_courseRev: [dictionary valueForKey:@"_rev"]];                           
}

+(id)courseWithCourseId:(NSString*)courseId 
             coursename:(NSString*)courseName 
      coursedescription:(NSString*)courseDescription 
           coursepoints:(NSString*)coursePoints 
          courseteacher:(NSString*)courseTeacher 
      courseLitterature:(NSArray*)courseLitterature
            db_courseId:(NSString*)db_courseId
           db_courseRev:(NSString*)db_courseRev;
{

    return [[self alloc] initWithCourseId:courseId coursename:courseName coursedescription:courseDescription coursepoints:coursePoints courseteacher:courseTeacher courseLitterature:courseLitterature db_courseId: db_courseId db_courseRev: db_courseRev];
    
}

-(id)init
{
    return [self initWithCourseId:@"no-courseId" coursename:@"no-courseName" coursedescription:@"no description" coursepoints:@"0" courseteacher:@"No-teacher" courseLitterature:NULL db_courseId:@"no_id" db_courseRev: @"no-_rev"];
}

-(id)initWithCourseId:(NSString*)courseId 
           coursename:(NSString*)courseName 
    coursedescription:(NSString*)courseDescription 
         coursepoints:(NSString*)coursePoints 
        courseteacher:(NSString*)courseTeacher 
    courseLitterature:(NSArray*)courseLitterature
         db_courseId:(NSString*)db_courseId
         db_courseRev:(NSString*)db_courseRev
{
    if(self = [super init]) 
    {
        _courseId = [courseId copy];
        _courseName = [courseName copy];
        _courseDescription =[courseDescription copy];
        _coursePoints = [coursePoints copy];
        _courseTeacher = [courseTeacher copy]; //Should be User object
        _courseLitterature = [courseLitterature copy];
        courseSchedule = [NSArray array];
        _db_courseId = [db_courseId copy];
        _db_courseRev = [db_courseRev copy];
        
            
    }
    return self;
    
}
+(id)courseFromDictionaryWithEvents:(NSDictionary*)dictionaryWithEvents {
    
    Course *newCourse = [self courseFromDictionary:dictionaryWithEvents];
    NSMutableArray *tempSchedule = [NSMutableArray array];

    for(NSDictionary *event in [dictionaryWithEvents valueForKey:@"courseSchema"]){
        CourseEvent *newCourseEvent = [CourseEvent courseEventFromDictionary: event];
        [tempSchedule addObject:newCourseEvent]; 
       
    }    
    newCourse->courseSchedule = [NSArray arrayWithArray:tempSchedule];
    return newCourse;
}

-(NSInteger) startWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if([courseSchedule count] != 0)
    {
        return [[calendar components: NSWeekCalendarUnit fromDate:[[courseSchedule objectAtIndex:0] eventStartDate]] week];
    }
    else
    {
        return 0;
    }   
}

-(NSInteger) endWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if([courseSchedule count] != 0)
    {
        return [[calendar components: NSWeekCalendarUnit fromDate:[[courseSchedule lastObject] eventEndDate]] week];
    }
    else
    {
        return 0;
    }
}

-(void) addCourseEvent:(CourseEvent*) newEvent
{    
        //Init courseSchedule array when needed, instead of in init function?
   NSMutableArray* newArray = [NSMutableArray arrayWithArray:courseSchedule];
       
   [newArray addObject:newEvent];
    courseSchedule = newArray;
       
   //NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
    [self sortCourseEvents];
//    //Sort array  
//    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"eventStartDate" ascending:TRUE];
//    NSArray *sortDecArray = [NSArray arrayWithObject:sortDesc];
//       
            
}
-(void)sortCourseEvents{
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:courseSchedule];
    //Sort array  
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"eventStartDate" ascending:TRUE];
    NSArray *sortDecArray = [NSArray arrayWithObject:sortDesc];
    courseSchedule = [newArray sortedArrayUsingDescriptors:sortDecArray];
}

-(NSDictionary*) asDictionary // update course
{   
    
    NSArray *courseEvents = [NSArray  arrayWithArray:[self getEventsAsDictionarys]];
    NSArray *studentListinCourse = [NSArray arrayWithArray:[self getStudentsIds]];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                                self.courseId, @"courseId",
                                               self.courseName, @"courseName",
                   // [NSNumber numberWithInt:self.coursePoints], @"coursePoints",
                                                self.coursePoints, @"coursePoints",
                                       self.courseLitterature, @"courseLitterature",
                                           self.courseTeacher, @"courseTeacher",
                                       self.courseDescription, @"courseDescription", 
                                        courseEvents, @"courseSchema",    
                                       studentListinCourse, @"courseStudents", nil];
    return data;    
}
-(NSDictionary*) updateCourseAsDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self asDictionary]];
    [dict setValue:[self db_courseId] forKey:@"_id"];
    [dict setValue:[self db_courseRev] forKey:@"_rev"];
    return dict;
}
-(void)updateCourse {
    service = [[Services alloc]init];
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    [resultDictionary setDictionary:[service saveToDb:[self updateCourseAsDictionary]]];
    
    [self setDb_courseRev:[resultDictionary valueForKey:@"rev"]];
}

-(NSArray*)getEventsAsDictionarys
{
     NSMutableArray* eventArray = [NSMutableArray array];
    
    for(CourseEvent *event in courseSchedule)
    {
        [eventArray addObject:[event asDictionary]]; 
    }
    return eventArray;
}
-(NSArray*)getStudentsIds
{
    NSMutableArray *studentIdList = [NSMutableArray array];
    for(User *student in courseStudents)
    {
        [studentIdList addObject:student.db_id];
    }
    return studentIdList;
    
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
    return [NSString stringWithFormat:@"Kursnamn: %@\n KursID: %@\n Kurspoäng: %@\n Kursbeskrivning: %@\n Kurslitteratur: %@\n Kursstart vecka: %d\n Kursslut vecka: %d\n", self.courseName, self.courseId, self.coursePoints, self.courseDescription, self.courseLitterature, [self startWeek], [self endWeek]];
}

@end
