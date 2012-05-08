//
//  CourseEvent.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseEvent.h"
#import "Course.h"

@implementation CourseEvent
//Test
//Course* myCourse;

@synthesize classRoom = _classRoom, alternativeTeacher = _alternativeTeacher, eventDate = _eventDate, eventStartTime = _eventStartTime, eventStopTime = _eventStopTime, eventReadingInstructions = _eventReadingInstructions;


+(id)courseEventWithDate:(NSDate*)eventDate 
          eventStartTime:(NSUInteger) eventStartTime
           eventStopTime:(NSUInteger) eventStopTime 
               classRoom:(NSString*) classRoom 
      alternetiveTeacher:(NSString*) alternativeTeacher 
eventReadingInstructions:(NSString*) eventReadingInstructions 
                  
{
    
    return [[self alloc] initWithDate:eventDate eventStartTime:eventStartTime eventStopTime:eventStopTime classRoom:classRoom alternetiveTeacher:alternativeTeacher eventReadingInstructions:eventReadingInstructions];
    
}

-(id)init
{
    return [self initWithDate:[NSDate dateWithString:@"no-date"]  eventStartTime:0 eventStopTime:0 classRoom:@"no-room" alternetiveTeacher:@"no-alternetive-teacher" eventReadingInstructions:@"no-reainginstructions"];
              
}

-(id)initWithDate:(NSDate*)eventDate 
                    eventStartTime:(NSUInteger) eventStartTime
                     eventStopTime:(NSUInteger) eventStopTime 
                         classRoom:(NSString*) classRoom 
                alternetiveTeacher:(NSString*) alternativeTeacher 
          eventReadingInstructions:(NSString*) eventReadingInstructions
                            
{
    if(self = [super init]) 
    {
        _eventDate = [eventDate copy];
        _eventStartTime = eventStartTime;
        _eventStopTime = eventStopTime;
        _classRoom = [classRoom copy];
        _alternativeTeacher = [alternativeTeacher copy]; //Should be User object
        _eventReadingInstructions = [eventReadingInstructions copy];
        
        
    }
    return self;
}

-(NSDictionary*) asDictionary
{
    NSString* eventDateAsString = [self.eventDate descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:
                                            [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];

    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:eventDateAsString, @"eventDate",
                                                                    self.classRoom, @"classRoom",
                                       [NSNumber numberWithInt:self.eventStartTime],@"eventStartTime",
                                        [NSNumber numberWithInt:self.eventStopTime],@"eventStopTime",
                                                            self.alternativeTeacher,@"alternativeTeacher",
                          self.eventReadingInstructions,@"eventReadingInstructions", nil]; 
                                                        
    return data;
    
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Lektion --> Datum: %@ Starttid %d Sluttid %d Kurslokal: %@ Readinstruct: %@\n", self.eventDate, self.eventStartTime, self.eventStopTime, self.classRoom, self.eventReadingInstructions];
}

@end
