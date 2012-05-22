//
//  MainApp.m
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainApp.h"
#import "User.h"
#import "Course.h"
#import "CourseEvent.h"
#import "UserServices.h"
#import "CourseServices.h"

NSArray *allUsers, *allCourses;

User *activeUser;
Course *activeCourse;

@implementation MainApp

@synthesize activeUser = _activeUser;

-(void) initApp
{
    
    
    char inputUserId[40];
   // char inputCourseId[40];
    NSLog(@"Hej vem är du?");
    scanf("%s", &inputUserId);
    [self loadUserData:[NSString stringWithCString:inputUserId encoding:NSUTF8StringEncoding]];
    //NSLog(@"Give me courseid!");
    //scanf("%s", &inputCourseId);
    //[self loadCourseData:[NSString stringWithCString:inputCourseId encoding:NSUTF8StringEncoding]];


    
}

-(void) initMenu
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 0)
        {
            switch (inputUserMenue) {
                case 1:
                    NSLog(@"%@",[activeUser dailySchema:[NSDate date]]);
                    break;
                
                case 2:
                    NSLog(@"%@",[activeUser weeklySchema:thisWeekNum]);
                    break;
                case 3:
                    [activeUser dailyInstructions:[NSDate date]];
                    break;
                case 4:
                    [activeUser weeklyInstructions:thisWeekNum];
                    break;
                case 5:
                    [self newStudent];
                    break;
                default:
                    break;
            }
        }
        
        NSLog(@"Visa:\n");
        NSLog(@"dagschema: 1\n");
        NSLog(@"veckoshema: 2\n");
        NSLog(@"dagens läsinstruktioner: 3\n");
        NSLog(@"veckans läsinstruktioner: 4\n");
        NSLog(@"create new user: 5\n");
        NSLog(@"Avlsuta: 0\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue > 0);
    
    
   //NSLog(@"\nDu är %d",inputUserMenue);
}

-(void)loadUserData:(NSString*) userid
{   
    // UserService
    UserServices *userService = [[UserServices alloc]init];
    //NSLog(@"LoadUserData");
    
    //*** Test data
   // activeUser = [User userWithUserEmail:@"test@gmail.com" username:@"Test" lastName:@"Testsson" role:ATRoleStudent];
    
   // activeUser = [User userFromDictionary:[userService dictionaryFromDbJson:userid]];//@"pedronygren@gmail.com"]];
    activeUser = [User userFromDictionaryWithCourses:[userService dictionaryFromDbJson:userid]];
    NSLog(@"dict2: %@", [userService dictionaryFromDbJson:userid]);
  
   // NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
   // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     //      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
    
   // Course *courseApputv = [Course courseWithCourseId:@"AppUtv2012" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:@"400" courseteacher:@"Anders Carlsson" courseLitterature:litterature db_courseId:@"" db_courseRev:@""];
    
    //Course *courseApputv = [Course courseWithCourseId:@"AppUtv2012" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:@"400" courseteacher:@"Anders Carlsson" courseLitterature:litterature];
         /*   CourseEvent *lecture1 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-05-09 08:15:00 +0000"]] 
                                            eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-10-31 11:15:00 +0000"]] 
                                                           classRoom:@"401" 
                                                      alternetiveTeacher:@"" 
                                                 eventReadingInstructions:@"Read chap 1"];
           
            CourseEvent *lecture2 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-05-21 12:15:00 +0000"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-06-01 13:15:00 +0000"]] classRoom:@"402" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 4"]; 
         
            CourseEvent *lecture3 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-03"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-03"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
            
           CourseEvent *lecture4 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 2"]; 
           
          CourseEvent *lecture5 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 09:15:00 +0000 ", @"2012-05-10"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-10"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
            
           CourseEvent *lecture6 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-15"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-15"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 5"]; 
            
          CourseEvent *lecture7 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
           
            CourseEvent *lecture8 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-17"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-17"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 6"]; */
    
    //Adding coursEvents to Course
         // [courseApputv addCourseEvent:lecture1];
         // [courseApputv addCourseEvent:lecture2];
             /*
          [courseApputv addCourseEvent:lecture3];
          [courseApputv addCourseEvent:lecture4];
          [courseApputv addCourseEvent:lecture5];
          [courseApputv addCourseEvent:lecture6];
          [courseApputv addCourseEvent:lecture7];
          [courseApputv addCourseEvent:lecture8];
        */
          
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    // problem in adding student to course
    
    //[courseApputv addStudentToCourse:activeUser];
    //[activeUser addCourseToUser:courseApputv];
    // save user, save course
    // update to db, user and course
    
   // Services *service = [[Services alloc]init];
    //[service saveToDb:[courseApputv asDictionary]];
}
-(void)newStudent {
    
    char e[40];
    char n[40];
    char l[40];
    
   
    NSLog(@"email?");
    scanf("%s", &e);
    NSLog(@"Name");
    scanf("%s", &n);
    NSLog(@"Last Name");
    scanf("%s", &l);
    
    NSString *email = [NSString stringWithCString:e encoding:NSUTF8StringEncoding];
    NSString *name = [NSString stringWithCString:n encoding:NSUTF8StringEncoding];
    NSString *lastName = [NSString stringWithCString:l encoding:NSUTF8StringEncoding];

    User *student = [User userWithUserEmail:email username:name lastName:lastName role:ATRoleStudent db_id:@"" db_rev:@"" status:ATUserStatusActive];
    Services *service = [[Services alloc]init];
    [service saveToDb:[student saveUserAsDictionary]];
    
}
-(void)loadCourseData:(NSString*) courseid
{
   // CourseServices *courseService = [[CourseServices alloc]init];
   // activeCourse = [Course courseFromDictionary:[courseService dictionaryFromDbJson:courseid]];//@"pedronygren@gmail.com"]];
  //  NSLog(@"dict2: %@", [courseService dictionaryFromDbJson:courseid]);
}

-(void)loadAllData
{
    
}

-(User*) thisActiveUser
{
  return activeUser;
}

@end
