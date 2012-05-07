//
//  CourseEvent.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseEvent.h"

@implementation CourseEvent
//Test

@synthesize classRoom = _classRoom, alternativeTeacher = _alternativeTeacher, eventDate = _eventDate, eventStartTime = _eventStartTime, eventStopTime = _eventStopTime, eventReadingInstructions = _eventReadingInstructions;


+(id)courseEventWithDate:(NSDate*)eventDate 
          eventStartTime:(NSNumber*) eventStartTime
           eventStopTime:(NSNumber*) eventStopTime 
               classRoom:(NSString*) classRoom 
      alternetiveTeacher:(NSString*) alternativeTeacher 
eventReadingInstructions:(NSString*) eventReadingInstructions 
                  course:(Course*) course
{
    
    return [[self alloc] initWithDate:eventDate eventStartTime:eventStartTime eventStopTime:eventStopTime classRoom:classRoom alternetiveTeacher:alternativeTeacher eventReadingInstructions:eventReadingInstructions course:course];
    
}

-(id)init
{
    return [self initWithDate:[NSDate dateWithString:@"no-date"]  eventStartTime:[NSNumber numberWithInt:0] eventStopTime:[NSNumber numberWithInt:0] classRoom:@"no-room" alternetiveTeacher:@"no-alternetive teacher" eventReadingInstructions:@"no-reainginstructions" course:nil];
}

-(id)initWithDate:(NSDate*)eventDate 
                    eventStartTime:(NSNumber*) eventStartTime
                     eventStopTime:(NSNumber*) eventStopTime 
                         classRoom:(NSString*) classRoom 
                alternetiveTeacher:(NSString*) alternativeTeacher 
          eventReadingInstructions:(NSString*) eventReadingInstructions
                            course:(Course*) course
{
    if(self = [super init]) 
    {
        _eventDate = [eventDate copy];
        _eventStartTime = [eventStartTime copy];
        _eventStopTime =[eventStopTime copy];
        _classRoom = [classRoom copy];
        _alternativeTeacher = [alternativeTeacher copy]; //Should be User object
        _eventReadingInstructions = [eventReadingInstructions copy];
        course = course;
        
    }
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Kurstillfälle --- \n Kurslokal: %@\n", self.classRoom];
}

@end
