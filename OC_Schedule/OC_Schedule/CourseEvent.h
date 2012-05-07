//
//  CourseEvent.h
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Course;

@interface CourseEvent : NSObject


@property(nonatomic, copy) NSString *classRoom;
@property(nonatomic, copy) NSString *alternativeTeacher;
//@property(nonatomic) Course *course;
@property(nonatomic, copy) NSDate *eventDate;
@property(nonatomic) NSUInteger eventStartTime;
@property(nonatomic) NSUInteger eventStopTime;
@property(nonatomic, copy) NSString *eventReadingInstructions;

// create course event
// override init
+(id)courseEventWithDate:(NSDate*)eventDate 
                eventStartTime:(NSUInteger) eventStartTime
                 eventStopTime:(NSUInteger) eventStopTime 
                     classRoom:(NSString*) classRoom 
            alternetiveTeacher:(NSString*) alternativeTeacher 
      eventReadingInstructions:(NSString*) eventReadingInstructions
                          course:(Course*) course;

-(id)initWithDate:(NSDate*)eventDate 
               eventStartTime:(NSUInteger) eventStartTime
                eventStopTime:(NSUInteger) eventStopTime 
                    classRoom:(NSString*) classRoom 
           alternetiveTeacher:(NSString*) alternativeTeacher 
     eventReadingInstructions:(NSString*) eventReadingInstructions
                         course:(Course*) course;

// create dictionary
// create JSON
// save to db


@end
