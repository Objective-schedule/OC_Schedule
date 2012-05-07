//
//  CourseEvent.h
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"




@interface CourseEvent : NSObject


@property(nonatomic, copy) NSString *classRoom;
@property(nonatomic, copy) NSString *alternativeTeacher;
@property(nonatomic) Course *course;
@property(nonatomic, copy) NSDate *eventDate;
@property(nonatomic, copy) NSNumber *eventStartTime;
@property(nonatomic, copy) NSNumber *eventStopTime;
@property(nonatomic, copy) NSString *eventReadingInstructions;

// create course event
// override init
+(id)courseEventWithDate:(NSDate*)eventDate 
                eventStartTime:(NSNumber*) eventStartTime
                 eventStopTime:(NSNumber*) eventStopTime 
                     classRoom:(NSString*) classRoom 
            alternetiveTeacher:(NSString*) alternativeTeacher 
      eventReadingInstructions:(NSString*) eventReadingInstructions
                          course:(Course*) course;

-(id)initWithDate:(NSDate*)eventDate 
               eventStartTime:(NSNumber*) eventStartTime
                eventStopTime:(NSNumber*) eventStopTime 
                    classRoom:(NSString*) classRoom 
           alternetiveTeacher:(NSString*) alternativeTeacher 
     eventReadingInstructions:(NSString*) eventReadingInstructions
                         course:(Course*) course;

// create dictionary
// create JSON
// save to db


@end
