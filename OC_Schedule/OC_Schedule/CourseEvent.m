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

@synthesize classRoom = _classRoom, alternativeTeacher = _alternativeTeacher, eventStartDate = _eventStartDate, eventEndDate = _eventEndDate, eventReadingInstructions = _eventReadingInstructions;


+(id)courseEventWithStartDate:(NSDate*)eventStartDate 
            eventEndDate:(NSDate*) eventEndDate 
               classRoom:(NSString*) classRoom 
      alternetiveTeacher:(NSString*) alternativeTeacher 
eventReadingInstructions:(NSString*) eventReadingInstructions 
                  
{
    
    return [[self alloc] initWithStartDate:eventStartDate eventEndDate:eventEndDate classRoom:classRoom alternetiveTeacher:alternativeTeacher eventReadingInstructions:eventReadingInstructions];
    
}

-(id)init
{
    return [self initWithStartDate:[NSDate dateWithString:@"no-date"]  eventEndDate:[NSDate dateWithString:@"no-date"] classRoom:@"no-room" alternetiveTeacher:@"no-alternetive-teacher" eventReadingInstructions:@"no-reainginstructions"];
              
}

-(id)initWithStartDate:(NSDate*)eventStartDate 
                        eventEndDate:(NSDate*) eventEndDate 
                         classRoom:(NSString*) classRoom 
                alternetiveTeacher:(NSString*) alternativeTeacher 
          eventReadingInstructions:(NSString*) eventReadingInstructions
                            
{
    if(self = [super init]) 
    {
        _eventStartDate = [eventStartDate copy];
        _eventEndDate = [eventEndDate copy];
        _classRoom = [classRoom copy];
        _alternativeTeacher = [alternativeTeacher copy]; //Should be User object
        _eventReadingInstructions = [eventReadingInstructions copy];
        
        
    }
    return self;
}

-(NSDictionary*) asDictionary
{
   NSString* eventStartDateAsString = [self.eventStartDate descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    
    NSString* eventEndDateAsString = [self.eventEndDate descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    

    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:eventStartDateAsString, @"eventStartDate",
                                                                    eventEndDateAsString, @"eventEndDate",
                                                                    self.classRoom, @"classRoom",
                                        self.alternativeTeacher,@"alternativeTeacher",
                          self.eventReadingInstructions,@"eventReadingInstructions", nil]; 
                                                        
    return data;
    
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Lektion --> Datum: %@ Sluttid %@ Kurslokal: %@ Readinstruct: %@\n", self.eventStartDate, self.eventEndDate, self.classRoom, self.eventReadingInstructions];
}

@end
