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
Services *service;
User *activeUser;
Course *activeCourse;
User *tempUser;
Course *tempCourses;

@implementation MainApp

@synthesize activeUser = _activeUser, tempUser = _tempUser, tempCourses = _tempCourses;

-(void) initApp
{
    service = [[Services alloc]init];
    
    char inputUserId[40];
   // char inputCourseId[40];
    NSLog(@"Hej vem är du?");
    scanf("%s", &inputUserId);
    [self checkLogin:[NSString stringWithCString:inputUserId encoding:NSUTF8StringEncoding]];
    //NSLog(@"Give me courseid!");
    //scanf("%s", &inputCourseId);
    //[self loadCourseData:[NSString stringWithCString:inputCourseId encoding:NSUTF8StringEncoding]];


    
}

-(void) studentMenu
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
        {
            NSLog(@"inputUserMenue: %i",inputUserMenue);

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
                case 6:
                    [self newCourse];
                    break;
                default:
                    NSLog(@"default");
                    break;
            }
        }
        
        NSLog(@"Visa:\n");
        NSLog(@"dagschema: 1\n");
        NSLog(@"veckoshema: 2\n");
        NSLog(@"dagens läsinstruktioner: 3\n");
        NSLog(@"veckans läsinstruktioner: 4\n");
        NSLog(@"create new user: 5\n");
        NSLog(@"create new course: 6\n");
        NSLog(@"Avlsuta: 9\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
    
    
   //NSLog(@"\nDu är %d",inputUserMenue);
}

-(void) adminMenu
{
    // GET ALL STUDENTS //
    
    NSDictionary* adminAllStudents = [NSDictionary dictionaryWithDictionary:[service getAllStudents]];
    
    NSMutableArray* tempAllStudentsArr = [[NSMutableArray alloc]init];
    
    for (id myDict in [adminAllStudents valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempUser = [User userFromDictionary:[myDict valueForKey:@"key"]];
        
        //add ready object to temporary array
        [tempAllStudentsArr addObject:tempUser];// resultatet ifrån saveUserAsDictionary komm in hit ];
    }
    allUsers = tempAllStudentsArr;
    
    NSLog(@"testing all users: %@" ,allUsers);
    
    // GET ALL COURSES //
    
    
    NSDictionary* adminAllCourses = [NSDictionary dictionaryWithDictionary:[service getAllCourses]];
    
    
    NSMutableArray* tempAllCoursesArr = [[NSMutableArray alloc]init];
    
    for (id myDict in [adminAllCourses valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempCourses = [Course courseFromDictionary:[myDict valueForKey:@"key"]];
        //add ready object to temporary array
        [tempAllCoursesArr addObject:tempCourses];// resultatet ifrån saveUserAsDictionary komm in hit ];
    }
    
    allCourses = tempAllCoursesArr;
    
    NSLog(@"testing all courses: %@" ,allCourses);
    
    
    
    /////////////////////////////
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
        {
            switch (inputUserMenue) {
                case 1:
                    NSLog(@"%@",[activeUser dailySchema:[NSDate date]]);
                    break;
                    
                case 2:
                    NSLog(@"%@",[activeUser weeklySchema:thisWeekNum]);
                    break;
                case 3:
                    [self adminCourseMenu];
                    break;
                case 4:
                    [activeUser weeklyInstructions:thisWeekNum];
                    break;
                default:
                    break;
            }
        }
        
        NSLog(@"Visa:\n");
        NSLog(@"Lägg till student: 1\n");
        NSLog(@"Lägg till kurs: 2\n");
        NSLog(@"aministrera kurs: 3\n"); //skapar ny meny med ny alternativ
        NSLog(@"veckans läsinstruktioner: 4\n");
        NSLog(@"Avlsuta: 0\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
    
    
    //NSLog(@"\nDu är %d",inputUserMenue);
    
}

-(void) adminCourseMenu
{
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
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
                    [self adminMenu];
                    break;
                default:
                    break;
            }
        }
        
        NSLog(@"Visa:\n");
        NSLog(@"Lägg till kurstillfälle: 1\n");
        NSLog(@"Uppdatera kurstillfälle: 2\n");
        NSLog(@"Lägg till student till kursen: 3\n"); 
        NSLog(@"Uppdatera befintlig kurs: 4\n");
        NSLog(@"Tillbaka till huvudmeny: 5\n");
        
        NSLog(@"Avlsuta: 0\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
    
    
    //NSLog(@"\nDu är %d",inputUserMenue);
    
}


//create menues

-(void)checkLogin:(NSString* ) userid
{   
    // create UserService
    UserServices *userService = [[UserServices alloc]init];
    
    //get userDictionary from Db
    activeUser = [User userFromDictionary:[userService dictionaryFromDbJson:userid]];
    NSDictionary *loginUserDict = [userService dictionaryFromDbJson:userid];
    
    //check if role is admin or student
    NSString *admin = [[NSString alloc] initWithFormat:@"Admin"];
    NSString *student = [[NSString alloc] initWithFormat:@"Student"];
    
    if([[loginUserDict valueForKey:@"role"] isEqualToString:student]) {
        NSLog(@"you are student");
        
        [self studentMenu];
        
    }else if([[loginUserDict valueForKey:@"role"] isEqualToString:admin]){
        NSLog(@"you are Admin");
        [self adminMenu];
    }
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
    //Services *service = [[Services alloc]init];
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service saveToDb:[student saveUserAsDictionary]]];
    
    // get back the id and rev to update the newly created user
    student.db_id = [resultDictionary valueForKey:@"id"];
    student.db_rev = [resultDictionary valueForKey:@"rev"];
    NSLog(@"student: %@", student);
//    [student updateUserAsDictionary];
}
-(void)newCourse {
    
    
    char ci[40];//courseid
    char cn[40];//coursename
    char cd[40];//course description
    char cp[40];//course points
    char ct[40];//course teacher
    int numberOfBooks;//course litterature
    char book[40];
    
    NSMutableArray *litterature = [NSMutableArray array];
    // ask how scanf or something similar can take spaces
    
    NSLog(@"courseId: ");
    scanf("%s", &ci);
    NSLog(@"coursename: ");
    scanf("%s", &cn);
    NSLog(@"course description: ");
    scanf("%s", &cd);
    NSLog(@"course points: ");
    scanf("%s", &cp);
    NSLog(@"course teacher: ");
    scanf("%s", &ct);
    
    NSLog(@"how many books: ");
    scanf("%i", &numberOfBooks);
    for (int j = 0; j < numberOfBooks; j++) {
        NSLog(@"enter title of book number %d:", j);
        scanf("%s", &book);
        [litterature addObject:[NSString stringWithCString:book encoding:NSUTF8StringEncoding]];
    }

    NSString *courseid = [NSString stringWithCString:ci encoding:NSUTF8StringEncoding];
    NSString *coursename = [NSString stringWithCString:cn encoding:NSUTF8StringEncoding];
    NSString *coursedescription = [NSString stringWithCString:cn encoding:NSUTF8StringEncoding];
    NSString *coursepoints = [NSString stringWithCString:cp encoding:NSUTF8StringEncoding];
    NSString *courseteacher = [NSString stringWithCString:ct encoding:NSUTF8StringEncoding];
    

    Course *course = [Course courseWithCourseId:courseid coursename:coursename coursedescription:coursedescription coursepoints:coursepoints courseteacher:courseteacher courseLitterature:litterature db_courseId:@"" db_courseRev:@""];
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionaryWithDictionary:[service saveToDb:[course asDictionary]]];
    
    // get back the id and rev to update the newly created user
    course.db_courseId = [resultDictionary valueForKey:@"id"];
    course.db_courseRev = [resultDictionary valueForKey:@"rev"];
    NSLog(@"course: %@", course);
     char answer[10];
     NSString *answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    
    NSLog(@"want to create event for this course: y / n ");
    scanf("%s", &answer);
    do {

       // NSLog(@"are we there yet!!!!");
        
        char startdateforevent[40];
        char starttimeofevent[40];
        char endtimeforevent[40];
        char classroom[40];
        char altteacher[40];
        char eventreadinginst[40];
        char eventdesc[40];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSLog(@"classroom number:");
        scanf("%s", &classroom);
        NSLog(@"alternative teacher ");
        scanf("%s", &altteacher);
        NSLog(@"event reading instructions ");
        scanf("%s", &eventreadinginst);
        NSLog(@"event description ");
        scanf("%s", &eventdesc);
        
        NSString *startdateforeventstart = [NSString stringWithCString:startdateforevent encoding:NSUTF8StringEncoding];
        startdateforeventstart = [startdateforeventstart stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
        NSString *starttimeofeventstart = [NSString stringWithCString:starttimeofevent encoding:NSUTF8StringEncoding];
        starttimeofeventstart = [starttimeofeventstart stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        NSString *endtimeforeventend = [NSString stringWithCString:endtimeforevent encoding:NSUTF8StringEncoding];
        endtimeforeventend = [endtimeforeventend stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        NSString *classroomev = [NSString stringWithCString:classroom encoding:NSUTF8StringEncoding];
        NSString *altteachereve = [NSString stringWithCString:altteacher encoding:NSUTF8StringEncoding];
        NSString *eventreadinginsteve = [NSString stringWithCString:eventreadinginst encoding:NSUTF8StringEncoding];
        NSString *eventdesceve = [NSString stringWithCString:eventdesc encoding:NSUTF8StringEncoding];
        
        CourseEvent *event = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-05-23 08:15"]]  eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@", @"2012-05-23 12:15"]] classRoom:classroomev alternetiveTeacher:altteachereve eventReadingInstructions:eventreadinginsteve eventDescription:eventdesceve];
        [course addCourseEvent:event];
        NSLog(@"course: %@", course);
        [resultDictionary setDictionary:[service saveToDb:[course updateCourseAsDictionary]]];
        
        course.db_courseRev = [resultDictionary valueForKey:@"rev"];
        
        NSLog(@"want to create event for this course: y / n ");
        scanf("%s", &answer);
        // if more than one event is created "document update conflict" from db and no error
        answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    } while ([answ isEqualToString:@"y"]);

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
