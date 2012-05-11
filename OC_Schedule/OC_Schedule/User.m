//
//  User.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "Course.h"
#import "CourseEvent.h"

extern NSString *const ATRoleStudent = @"Student";
extern NSString *const ATRoleTeacher = @"Teacher";
extern NSString *const ATRoleAdmin = @"Admin";

extern NSString *const ATUserStatusActive = @"Active";
extern NSString *const ATUserStatusInactive = @"Inactive";



@implementation User

{
   NSArray *userCourses; 
}



@synthesize userName = _userName, lastName = _lastName, userEmail = _userEmail,
userMessages = _userMessages, userRole = _userRole;

+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role {
    return [[self alloc] initWithUserEmail:userEmail username:userName lastName:lastName role:ATRoleStudent];
}
-(id) init {
    return [self initWithUserEmail:@"no-user-email" username:@"no-username" lastName:@"no-userlastName" role:@"no-user-role"];
}

-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role {
    if(self = [super init]) {
        _userName = [userName copy];
        _lastName = [lastname copy];
        _userEmail = [userEmail copy];
        _userRole = [role copy];
         userCourses = [NSArray array];
    }
    return self;
}
-(NSString*) description {
    return [NSString stringWithFormat:@"%@, %@, %@, %@", self.userName, self.lastName, self.userEmail, self.userRole];
}
// create dictionary with user
-(NSDictionary*)saveUserAsDictionary {
    NSDictionary *dictionaryWithUser = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"name",self.lastName, @"lastName",self.userEmail, @"email", self.userRole, @"role", nil];
    return dictionaryWithUser;
}

-(void) addCourseToUser:(Course*) course
{
    
    //Init userCourses array when needed, instead of in init function?
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userCourses];
    
    [newArray addObject:course];
          
    userCourses = newArray;
}

-(NSArray*) allCourseEvents
{
    NSMutableArray *totalEvents = [NSMutableArray array];
    for(Course* course in userCourses)
    {
        for(CourseEvent *event in [course allEvents])
        {
            [totalEvents addObject:event];
        }
    }
    
    //NSLog(@"%@", allEvents);
    return totalEvents;
}

-(NSArray*) dailySchema:(NSDate*) dateToShow
{
    NSMutableArray *dailyEvents = [NSMutableArray array];

    NSString *dateToShowString = [dateToShow descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:
    [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
   
    NSLog(@"TODAY -> %@", dateToShowString);
    for(Course* course in userCourses)
    {
        for(CourseEvent *event in [course allEvents])
        {
            if([dateToShowString isEqualToString:[[event eventStartDate] descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:
               [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]])
            {
                        
                [dailyEvents addObject:event];
            }
                
        }
    }

        return dailyEvents;

}

-(NSArray*) weeklySchema:(NSInteger) weekNum
{
    // set up date components
    //NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // create a calendar
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if(weekNum == 0 || weekNum > 52)
    {   
        NSDate *today = [NSDate date];
        weekNum = [[gregorian components: NSWeekCalendarUnit fromDate:today] week];
    }
    
    //NSLog(@"weekNumber: %ld", weekNum); 
    NSMutableArray *weeklyEvents = [NSMutableArray array];
    for(Course* course in userCourses)
    {
        if(weekNum >= [course startWeek] && weekNum <= [course endWeek])
        {   
            NSLog(@"%@", course);
            for(CourseEvent *event in [course allEvents])
            {   
                if(weekNum == [[gregorian components: NSWeekCalendarUnit fromDate:[event eventStartDate]] week])
                {
                    // NSLog(@"%@", [event eventDate]);
                    
                    [weeklyEvents addObject:event];
                }
            }

        }
    }

    return weeklyEvents;
}

-(void) dailyInstructions:(NSDate*) dateToShow
{
    NSArray *events = [NSArray arrayWithArray:[self dailySchema:dateToShow]];
    
    for(CourseEvent *event in events)
    {
        NSLog(@"%@\n", [event eventReadingInstructions]);
    }
  
    
}
-(void) weeklyInstructions:(NSInteger) weekNum
{
    NSArray *events = [NSArray arrayWithArray:[self weeklySchema:weekNum]];
    NSMutableDictionary *eventDict = [NSMutableDictionary dictionary];
    
    NSMutableString *currentDate;// = [NSMutableString ] [dateToShow descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:
      //                            [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
    
    for(CourseEvent *event in events)
    {
                      
        NSLog(@"%@\n", [event eventReadingInstructions]);
    }
}
@end
