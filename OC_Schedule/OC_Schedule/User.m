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
#import "Services.h"
#import "UserServices.h"
#import "Message.h"

extern NSString *const ATRoleStudent = @"Student";
extern NSString *const ATRoleTeacher = @"Teacher";
extern NSString *const ATRoleAdmin = @"Admin";

extern NSString *const ATUserStatusActive = @"Active";
extern NSString *const ATUserStatusInactive = @"Inactive";



@implementation User

{
    NSArray *userCourses;
    NSArray *userMessages;

    Services *service;
}


@synthesize userName = _userName, lastName = _lastName, userEmail = _userEmail, userRole = _userRole, db_id = _db_id, db_rev = _db_rev, status = _status;

+(id) userFromDictionary:(NSDictionary*) dictionary {
    
    return [self userWithUserEmail:[dictionary valueForKey:@"email"]
                          username:[dictionary valueForKey:@"name"]
                          lastName:[dictionary valueForKey:@"lastName"]
                              role:[dictionary valueForKey:@"role"]
                             db_id: [dictionary valueForKey:@"_id"]
                            db_rev: [dictionary valueForKey:@"_rev"]
                            status: [dictionary valueForKey:@"status"]];
}
+(id)userFromDictionaryWithCourses:(NSDictionary*)dictionaryWithCourses {
    
    User *newUser = [self userFromDictionary:dictionaryWithCourses];
    
    UserServices *userServices = [[UserServices alloc]init];
    Services *service = [[Services alloc]init];
    
    //NSLog(@"[dictionaryWithCourses: %@", [dictionaryWithCourses valueForKey:@"studentCourses"]);
    
    for(NSString *courseId in [dictionaryWithCourses valueForKey:@"studentCourses"]){

        Course *newCourse = [Course courseFromDictionaryWithEvents:[service getUniqeDoc:courseId]];

        [newUser addCourseToUser:newCourse];
        //NSLog(@"courseid: %@",courseId);
    }   
    //NSLog(@"new user: %@", newUser);
   NSArray *arrayWithDictionaryWithMessages = [userServices dictionaryFromMessageDbJson:[newUser db_id]]; 
    for(NSDictionary *message in arrayWithDictionaryWithMessages){
        //NSLog(@"the messages: %@",[message valueForKey:@"value"]);
        Message *tempMessage = [Message messageFromDictionary:[message valueForKey:@"value"]];
        [newUser addMessageToUser:tempMessage];
    }
    //NSLog(@"newUser: %@", newUser);
    //[newUser getMessages];
    return newUser;
}
//+(id)userFromDictionaryWithMessages: (NSDictionary*)dictionaryWithMessages {
//    
//    User *tempUser = [self userFromDictionary:dictionaryWithMessages];
//    NSMutableArray *tempMessages = [NSMutableArray array];
//
////    Services *service = [[Services alloc]init];
////    for(NSString *messageId in [dictionaryWithMessages valueForKey:@"studentMessages"]){
////
////        Message *tempMessage = [Message messageFromDictionary:[service getUniqeDoc:messageId]];
////        [tempUser addMessageToUser:tempMessage];
////    }
////    NSLog(@"new user: %@", tempUser);
//    for(NSDictionary *event in [dictionaryWithMessages valueForKey:@"studentMessages"]){
//        Message *tempMessage = [Message messageFromDictionary: event];
//        [tempMessages addObject:tempMessage]; 
//    }    
//    tempUser->userMessages = [NSArray arrayWithArray:tempMessages];
//    NSLog(@"tempUser from userFromDictionaryWithMessages: %@", tempUser);
//    return tempUser;
//
//}

+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status {
    return [[self alloc] initWithUserEmail:userEmail username:userName lastName:lastName role:ATRoleStudent db_id:db_id db_rev: db_rev status:status];
}

-(id) init {
    return [self initWithUserEmail:@"no-user-email" username:@"no-username" lastName:@"no-userlastName" role:@"no-user-role" db_id: @"no _id" db_rev:@"no _rev" status:@"no-status"];
}

-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role db_id:(NSString*)db_id db_rev:(NSString*)db_rev status:(NSString*)status{
    if(self = [super init]) {
        _userName = [userName copy];
        _lastName = [lastname copy];
        _userEmail = [userEmail copy];
        _userRole = [role copy];
        _db_id = [db_id copy];
        _db_rev = [db_rev copy];
        _status = [status copy];
        userCourses = [NSArray array];
        userMessages = [NSArray array];
        
    }
    return self;
}
-(NSString*) description {
    [self getCoursesIds];
    return [NSString stringWithFormat:@" users from all users: %@, %@, %@, %@, %@, %@, %@, %@, messages: %@", self.userName, self.lastName, self.userEmail, self.userRole, self.db_id, self.db_rev, self.status, userCourses, userMessages];
}
// create new dictionary with new user
-(NSDictionary*)saveUserAsDictionary {
    NSDictionary *dictionaryWithUser = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"name",self.lastName, @"lastName",self.userEmail, @"email", self.userRole, @"role", self.status, @"status", nil];
    return dictionaryWithUser;
}
// create new dictionary with update user
// to do: add messages here ***********
-(NSDictionary*)updateUserAsDictionary {
    
    NSArray *courseListinStudent = [NSArray arrayWithArray:[self getCoursesIds]];
   // NSArray *messageListinStudent = [NSArray arrayWithArray:[self getMessagesIds]];

    NSDictionary *dictionaryWithUser = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"name",self.lastName, @"lastName",self.userEmail, @"email", self.userRole, @"role", self.db_id, @"_id", self.db_rev, @"_rev", self.status, @"status",courseListinStudent, @"studentCourses",  nil];
    
    NSLog(@"dictionaryWithUser update _id, _rev: %@",dictionaryWithUser);
    return dictionaryWithUser;
}
-(void)updateUser {
    service = [[Services alloc]init];
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    [resultDictionary setDictionary:[service saveToDb:[self updateUserAsDictionary]]];
    NSLog(@"self: %@", self);
    [self setDb_rev:[resultDictionary valueForKey:@"rev"]];
}

-(void) addCourseToUser:(Course*) course
{
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userCourses];
    
    [newArray addObject:course];
          
    userCourses = newArray;
}
-(NSArray*)getCoursesIds
{
    NSMutableArray *courseIdList = [NSMutableArray array];
    for(Course *course in userCourses)
    {
        [courseIdList addObject:course.db_courseId];
        // NSLog(@"courses:%@",course);
    }
    return courseIdList;
    
}
-(void) addMessageToUser:(Message*) message
{
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userMessages];
    
    [newArray addObject:message];
    
    userMessages = newArray;
    NSLog(@"userMessages from addMessageToUser : %@", userMessages);

}
//-(void)addMessage:(NSString*)messageId {
//    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userMessages];
//    
//    [newArray addObject:messageId];
//    
//    userMessages = newArray;
//}

//-(NSArray*)getMessagesIds
//{
//     
//    NSMutableArray *messageIdList = [NSMutableArray array];
//    for(Message *message in userMessages)
//    {
//        [messageIdList addObject:message.db_id];
//         NSLog(@"messageIdList addObject:message.db_id:%@",messageIdList);
//    }
//    NSLog(@"messageIdList addObject:message.db_id:%@",messageIdList);
//
//    return messageIdList;
//    
//}

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
    
    return totalEvents;
}
-(NSArray*)getMessages{
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userMessages];
    //Sort array  
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"sentDate" ascending:FALSE];
    NSArray *sortDecArray = [NSArray arrayWithObject:sortDesc];
    userMessages = [newArray sortedArrayUsingDescriptors:sortDecArray];
    NSLog(@"userMessages sorted: %@", userMessages);
    return userMessages;    
}
-(NSArray*) dailySchema:(NSDate*) dateToShow
{
    NSMutableArray *dailyEvents = [NSMutableArray array];

    NSString *dateToShowString = [dateToShow descriptionWithCalendarFormat:@"%Y-%m-%d" timeZone:nil locale:
    [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
   
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
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if(weekNum == 0 || weekNum > 52)
    {   
        NSDate *today = [NSDate date];
        weekNum = [[calendar components: NSWeekCalendarUnit fromDate:today] week];
    }
    
    //NSLog(@"weekNumber: %ld", weekNum); 
    NSMutableArray *weeklyEvents = [NSMutableArray array];
    for(Course* course in userCourses)
    {
        if(weekNum >= [course startWeek] && weekNum <= [course endWeek])
        {   
            //NSLog(@"%@", course);
            for(CourseEvent *event in [course allEvents])
            {   
                if(weekNum == [[calendar components: NSWeekCalendarUnit fromDate:[event eventStartDate]] week])
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
   
    NSLog(@"Daily instruct");
    NSArray *events = [NSArray arrayWithArray:[self dailySchema:dateToShow]];
    if ([events count] > 1)
    {
        for(CourseEvent *event in events)
        {
            NSLog(@"%@ %@\n",[event eventStartDate], [event eventReadingInstructions]);
        }
    }
    else
    {
        NSLog(@"%@\n", [[events objectAtIndex:0] eventReadingInstructions]);
    }
    NSLog(@"\n");
    
}
-(void) weeklyInstructions:(NSInteger) weekNum
{
    NSLog(@"Weeky instruct");
    NSArray *events = [NSArray arrayWithArray:[self weeklySchema:weekNum]];

    NSString *prevDay, *currentDay;
    
    // *** Code for demo for displaying weekly intructions in the console
    for(CourseEvent *event in events)
    {
        currentDay =  [[event eventStartDate] descriptionWithCalendarFormat:@"%A" timeZone:nil locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
        
        if(![prevDay isEqualToString:currentDay])
         {  
            NSLog(@"%@", currentDay);
             prevDay = currentDay;
         }
        NSLog(@"%@\n", [event eventReadingInstructions]);
    }
     NSLog(@"\n");
}
@end
