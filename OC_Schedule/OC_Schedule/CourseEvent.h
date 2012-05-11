//
//  CourseEvent.h
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class Course;

@interface CourseEvent : NSObject


@property(nonatomic, copy) NSString *classRoom;
@property(nonatomic, copy) NSString *alternativeTeacher;
//@property(nonatomic) Course *myCourse;
//@property(nonatomic, copy) NSDate *eventDate;
@property(nonatomic) NSDate *eventStartDate;
@property(nonatomic) NSDate *eventEndDate;
@property(nonatomic, copy) NSString *eventReadingInstructions;

// create course event
// override init
+(id)courseEventWithStartDate:(NSDate*) eventStartDate
                 eventEndDate:(NSDate*) eventEndDate 
                     classRoom:(NSString*) classRoom 
            alternetiveTeacher:(NSString*) alternativeTeacher 
eventReadingInstructions:(NSString*) eventReadingInstructions;
                         

-(id)initWithStartDate:(NSDate*) eventStartDate
            eventEndDate:(NSDate*) eventEndDate 
               classRoom:(NSString*) classRoom 
        ternetiveTeacher:(NSString*) alternativeTeacher 
eventReadingInstructions:(NSString*) eventReadingInstructions;
                         


-(NSDictionary*) asDictionary;

// create dictionary
// create JSON
// save to db


@end
