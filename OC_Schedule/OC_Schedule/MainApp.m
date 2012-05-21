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

NSArray *allUsers, *allCourses;

User *activeUser;

@implementation MainApp

@synthesize activeUser = _activeUser;

-(void) initApp
{
    
    
    char inputUserId[40];
    NSLog(@"Hej vem är du?");
    scanf("%s", &inputUserId);
    [self loadUserData:[NSString stringWithCString:inputUserId encoding:NSUTF8StringEncoding]];
    

    
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
                default:
                    break;
            }
        }
        
        NSLog(@"Visa:\n");
        NSLog(@"dagschema: 1\n");
        NSLog(@"veckoshema: 2\n");
        NSLog(@"dagens läsinstruktioner: 3\n");
        NSLog(@"veckans läsinstruktioner: 4\n");
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
   /// activeUser = [User userWithUserEmail:@"test@gmail.com" username:@"Test" lastName:@"Testsson" role:ATRoleStudent];
    
    activeUser = [User userFromDictionary:[userService dictionaryFromDbJson:userid]];//@"pedronygren@gmail.com"]];
    NSLog(@"dict2: %@", [userService dictionaryFromDbJson:userid]);
  
    NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
           [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];

     Course *courseApputv = [Course courseWithCourseId:@"AppUtv2011" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
            CourseEvent *lecture1 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-09"]] 
                                            eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 11:15:00 +0000 ", @"2012-05-09"]] 
                                                           classRoom:@"401" 
                                                      alternetiveTeacher:@"" 
                                                 eventReadingInstructions:@"Read chap 1"];
           
            CourseEvent *lecture2 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 12:15:00 +0000 ", @"2012-05-21"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-06-01"]] classRoom:@"402" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 4"]; 
            
            CourseEvent *lecture3 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-03"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-03"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
            
           CourseEvent *lecture4 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 2"]; 
           
          CourseEvent *lecture5 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 09:15:00 +0000 ", @"2012-05-10"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-10"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
            
           CourseEvent *lecture6 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-15"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-15"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 5"]; 
            
          CourseEvent *lecture7 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
           
            CourseEvent *lecture8 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-17"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-17"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 6"]; 
    
    //Adding coursEvents to Course
          [courseApputv addCourseEvent:lecture1];
          [courseApputv addCourseEvent:lecture2];
          [courseApputv addCourseEvent:lecture3];
          [courseApputv addCourseEvent:lecture4];
          [courseApputv addCourseEvent:lecture5];
          [courseApputv addCourseEvent:lecture6];
          [courseApputv addCourseEvent:lecture7];
          [courseApputv addCourseEvent:lecture8];
        
          [courseApputv addStudentToCourse:activeUser];
          [activeUser addCourseToUser:courseApputv];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
}

-(void)loadAllData
{
    
}

-(User*) thisActiveUser
{
  return activeUser;
}

@end
