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
#import "Message.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
NSArray *allUsers, *allCourses;
Services *service;
User *activeUser;
Course *activeCourse;
User *tempUser;
Course *tempCourses;
Message *tempMessages;

@implementation MainApp
#define MAX_NAME_SZ 256

@synthesize activeUser = _activeUser, tempUser = _tempUser, tempCourses = _tempCourses;

-(void) initApp
{
    service = [[Services alloc]init];
    
    char inputUserId[40];
    NSLog(@"Logga in med din e-postadress!!");
    scanf("%s", &inputUserId);
    [self checkLogin:[NSString stringWithCString:inputUserId encoding:NSUTF8StringEncoding]];
    
}

-(void) studentMenu:(NSString*) userid

{
    UserServices *userService = [[UserServices alloc]init];
    activeUser = [User userFromDictionaryWithCourses:[userService dictionaryFromDbJson:userid]];
    
    //activeUser  = [User userFromDictionaryWithMessages:[userService dictionaryFromMessageDbJson:[activeUser.db_id];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
        {
           // NSLog(@"inputUserMenue: %i",inputUserMenue);

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
                    [self studentMessages];
                    break;
                case 6:
                    [self initApp];
                    break;
                default:
                    break;
            }
        }
        
        NSLog(@"Visa dagschema: 1\n");
        NSLog(@"Visa veckoshema: 2\n");
        NSLog(@"Visa dagens läsinstruktioner: 3\n");
        NSLog(@"Visa veckans läsinstruktioner: 4\n");
        NSLog(@"Visa mina meddelande: 5\n");
        NSLog(@"Logga ut: 6\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
}
-(void)studentMessages {
    NSLog(@"Messages: %@", [activeUser getMessages]);
}
-(void) adminMenu
{
    
    NSDictionary* adminAllStudents = [NSDictionary dictionaryWithDictionary:[service getAllStudents]];
    
    NSMutableArray* tempAllStudentsArr = [[NSMutableArray alloc]init];
    
    for (id myDict in [adminAllStudents valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempUser = [User userFromDictionary:[myDict valueForKey:@"key"]];
        
        //add ready object to temporary array
        [tempAllStudentsArr addObject:tempUser];// resultatet ifrån saveUserAsDictionary komm in hit ];
    }
    
    allUsers = tempAllStudentsArr;
    
    NSDictionary* adminAllCourses = [NSDictionary dictionaryWithDictionary:[service getAllCourses]];
    NSMutableArray* tempAllCoursesArr = [[NSMutableArray alloc]init];
    //NSMutableArray* tempAllMessagesArr = [[NSMutableArray alloc]init];

    for (id myDict in [adminAllCourses valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempCourses = [Course courseFromDictionaryWithEvents:[myDict valueForKey:@"key"]];
        //tempMessages = [Message messageFromDictionary:[myDict valueForKey:@"key"]];
        
        //NSLog(@"mydict: %@", [[myDict valueForKey:@"key"] valueForKey:@"courseStudents"]);
       // NSLog(@"mydict with studentMessages: %@", [[myDict valueForKey:@"key"] valueForKey:@"studentMessages"]);

        NSArray *courseStudents = [NSArray arrayWithArray:[[myDict valueForKey:@"key"] valueForKey:@"courseStudents"]];
       // NSLog(@"courseStudents: %@", courseStudents);
        for(NSString *stuid in courseStudents){
            //NSLog(@"stuid: %@",stuid);
            NSMutableArray *temp = [NSMutableArray arrayWithArray:allUsers];
            // NSLog(@"temp: %@", temp);
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"db_id == %@", stuid];
            //NSLog(@"predicate: %@", [predicate description]);
            NSArray *toBeReclaimed = [temp filteredArrayUsingPredicate:predicate];
           
            if([toBeReclaimed count] > 0) {
                [tempCourses addStudentToCourse:[toBeReclaimed objectAtIndex:0]];
                [[toBeReclaimed objectAtIndex:0]addCourseToUser:tempCourses];
            }
            //Course *activeCourse = [toBeReclaimed objectAtIndex:0];
            //NSLog(@"toBeReclaimed: %@", toBeReclaimed);
        }

        //add ready object to temporary array
        [tempAllCoursesArr addObject:tempCourses];// resultatet ifrån saveUserAsDictionary komm in hit ];
    }
    
    allCourses = tempAllCoursesArr;
    //NSLog(@"allcourses: %@", allCourses);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
    NSArray *simpleCourseList;
    NSArray *simpleStudentList;
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
        {
            switch (inputUserMenue) {
                case 1:
                    simpleCourseList = [self listAllCoursesSortedByName];
                    for(Course *simpleCourse in simpleCourseList){
                        NSLog(@"%@",[simpleCourse simpleDescription]);
                    }
                    break;
                case 2:
                    simpleStudentList = [self listAllStudentsSortedByName];
                    for(User *simpleUser in simpleStudentList){
                        NSLog(@"%@", [simpleUser simpleDescription]);
                    }
                    //[self listAllStudentsSortedByName];
                    break;
                case 3:
                    [self newCourse];
                    break;
                case 4:
                    [self newStudent];
                    break;
                case 5:
                    [self adminCourseMenu];
                    break;
                case 6:
                    [self newMessage];
                    break;
                case 7:
                    [self initApp];
                    break;
                default:
                    break;
            }
        }
        
        //NSLog(@"Visa:\n");
        NSLog(@"Lista alla kurser: 1\n");
        NSLog(@"Lista alla studenter: 2\n");
        NSLog(@"Skapa ny kurs: 3\n");
        NSLog(@"Skapa ny student: 4\n");
        NSLog(@"Administrera kurs: 5\n"); //skapar ny meny med ny alternativ
        NSLog(@"Skapa meddelande: 6\n");
        NSLog(@"Logga ut: 7\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
}

-(void) adminCourseMenu
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
    char cid[50];
    NSLog(@"\nAnge kurs id:");
     scanf("%s", &cid);
    NSString *courseid = [NSString stringWithCString:cid encoding:NSUTF8StringEncoding];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:allCourses]; 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseId == %@", courseid];
    NSArray *toBeReclaimed = [temp filteredArrayUsingPredicate:predicate];
    
    if([toBeReclaimed count] >0){
        Course *activeCourse = [toBeReclaimed objectAtIndex:0];
        int inputUserMenue = 10;
        
        do {
            if (inputUserMenue != 9)
            {
                switch (inputUserMenue) {
                    case 1:
                        [self newCourseEvent:activeCourse];
                        break;
                    case 2:
                        [self editCourseEvent:activeCourse];
                        break;
                    case 3:
                        [self addStudentToCourse:activeCourse];
                        break;
                    case 4:
                        [self adminMenu];
                        break;
                    default:
                        break;
                }
            }
            
            NSLog(@"Lägg till kurstillfälle: 1\n");
            NSLog(@"Uppdatera kurstillfälle: 2\n");
            NSLog(@"Lägg till student till kursen: 3\n"); 
            NSLog(@"Tillbaka till huvudmeny: 4\n");        
            scanf("%d", &inputUserMenue);
        } while (inputUserMenue != 9);
    }else {
        NSLog(@"Det finns ingen kurs med den id\n");
    }
}

-(void)checkLogin:(NSString* ) userid
{   
    // create UserService
    UserServices *userService = [[UserServices alloc]init];
    
    //get userDictionary from Db
//    NSLog(@"%@",[userService dictionaryFromDbJson:userid]);
    activeUser = [User userFromDictionary:[userService dictionaryFromDbJson:userid]];
    NSDictionary *loginUserDict = [userService dictionaryFromDbJson:userid];
    //NSLog(@"");
    //check if role is admin or student
    NSString *admin = [[NSString alloc] initWithFormat:@"Admin"];
    NSString *student = [[NSString alloc] initWithFormat:@"Student"];
    // ideal solution but needs more work
    /*if([activeUser.userRole isEqualToString:ATRoleAdmin]){
        NSLog(@"activeUser.userRole: %@", activeUser.userRole);
        [self adminMenu];
        
    } else{
        NSLog(@"you are stud");
        [self studentMenu];
    }*/
    
    if([[loginUserDict valueForKey:@"role"] isEqualToString:student]) {
       // NSLog(@"you are student");
        
        [self studentMenu: userid];
        
    }else if([[loginUserDict valueForKey:@"role"] isEqualToString:admin]){
       // NSLog(@"you are Admin");
        [self adminMenu];
    }
}


-(void)loadUserData:(NSString*) userid
{   
    UserServices *userService = [[UserServices alloc]init];
    activeUser = [User userFromDictionaryWithCourses:[userService dictionaryFromDbJson:userid]];
          
    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
}
-(void)newStudent {
    
    char e[40];
    char n[40];
    char l[40];
    
   
    NSLog(@"E-Post");
    scanf("%s", &e);
    NSLog(@"Namn");
    scanf("%s", &n);
    NSLog(@"Efternamn");
    scanf("%s", &l);
    
    NSString *email = [NSString stringWithCString:e encoding:NSUTF8StringEncoding];
    NSString *name = [NSString stringWithCString:n encoding:NSUTF8StringEncoding];
    NSString *lastName = [NSString stringWithCString:l encoding:NSUTF8StringEncoding];

    User *student = [User userWithUserEmail:email username:name lastName:lastName role:ATRoleStudent db_id:@"" db_rev:@"" status:ATUserStatusActive userMessages:nil];
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service saveToDb:[student saveUserAsDictionary]]];
    
    // get back the id and rev to update the newly created user
    student.db_id = [resultDictionary valueForKey:@"id"];
    student.db_rev = [resultDictionary valueForKey:@"rev"];
    //NSLog(@"student: %@", student);
}
-(void)newMessage {
    char t[255]; // title
    //char sd[40]; // sent date
    char co[255]; // content
    NSString *title;
    NSString *content;


    NSLog(@"Titel: ");
    scanf("%s", &t);
    
    NSLog(@"Innehåll");
    scanf("%s", &co);
    
    title = [NSString stringWithCString:t encoding:NSUTF8StringEncoding];
    content = [NSString stringWithCString:co encoding:NSUTF8StringEncoding];
 
    Message *message = [Message messageWithTitle:title sentDate:[NSDate date] content:content createdBy:[NSString stringWithFormat:@"%@ %@",activeUser.userName,activeUser.lastName] db_id:@"" db_rev:@""];
    
    char answerForSendingMessage[10];
    
    NSLog(@"Vill du skicka det här meddelandet till alla studenter? y = ja, n = nej ");
    scanf("%s", &answerForSendingMessage);
    NSString *answMessage = [NSString stringWithCString:answerForSendingMessage encoding:NSUTF8StringEncoding];
    
    if([answMessage isEqualToString:@"y"]){
        // send message to all students
        for (User *student in allUsers) {
            [message addStudent:student.db_id];      
        }
        
        NSMutableDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service  saveToDb:[message saveMessageAsDictionary]]];
        message.db_id = [resultDictionary valueForKey:@"id"];
        message.db_rev = [resultDictionary valueForKey:@"rev"];
        //NSLog(@"message.db_id from callback: %@", message.db_id);
        // save message id in student object
        for (User *student in allUsers) {
            [student addMessageToUser:message];
            //[student updateUser];
        }
        NSLog(@"Meddelande har skickats till alla studenter!");
    } else{
        // get list of student and display so that i can choose index
        int studentindex = 1000;
        //NSLog(@"students here: %@",[activeCourse allStudents]);
        NSLog(@"List med alla studenter: %@", [self listAllStudentsSortedByName]);
        NSLog(@"Valj en student index... Starta at index 0");
        scanf("%d", &studentindex);
        
        User *tempUser = [[self listAllStudentsSortedByName] objectAtIndex:studentindex];
        [message addStudent:tempUser.db_id];
        
        NSMutableDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service  saveToDb:[message saveMessageAsDictionary]]];
        message.db_id = [resultDictionary valueForKey:@"id"];
        message.db_rev = [resultDictionary valueForKey:@"rev"];
    }
        //NSLog(@"message: %@", message);
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
    
    NSLog(@"Ange kursId: ");
    scanf("%s", &ci);
    NSLog(@"Ange kursnamn: ");
    scanf("%s", &cn);
    NSLog(@"Ange kursbeskrivning: ");
    scanf("%s", &cd);
    NSLog(@"Ange kurspoäng: ");
    scanf("%s", &cp);
    NSLog(@"Ange kursläraren: ");
    scanf("%s", &ct);
    
    NSLog(@"hur många böcker?: ");
    scanf("%i", &numberOfBooks);
    for (int j = 0; j < numberOfBooks; j++) {
        NSLog(@"Ange titel bokningsnummer %d:", j);
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
    //NSLog(@"course: %@", course);
     char answer[10];
        
    NSLog(@"Vill du skapa evenemang för denna kurs: y / n ");
    scanf("%s", &answer);
    NSString *answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    
    if([answ isEqualToString:@"y"])
    {
        // NSLog(@"are we there yet!!!!");
        do {
            [self newCourseEvent:course];
            NSLog(@"Vill du skapa evenemang för denna kurs: y / n ");
            scanf("%s", &answer);
            // if more than one event is created "document update conflict" from db and no error
            answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
        } while ([answ isEqualToString:@"y"]);
    }
}

-(void)newCourseEvent:(Course*)activeCourse{

    //NSLog(@"activecourse: %@", activeCourse);
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
//    char startdateforevent[40];
//    char starttimeofevent[40];
//    char endtimeforevent[40];
    char classroom[40];
    char altteacher[256];
    char eventreadinginst[256];
    char eventdesc[256];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startDate;
    NSLog(@"Ange startdatum:");
    startDate = [self requestEventDate];
    NSDate *endDate;
    NSLog(@"Ange slutdatum:");
    endDate = [self requestEventDate];
    NSLog(@"Klassrummet antal:");
    scanf("%s", &classroom);
    NSLog(@"Alternativt läraren ");
    scanf("%s", &altteacher);
    NSLog(@"In läsanvisning: ");
    scanf("%s", &eventreadinginst);
    //NSLog(@"event reading instructions ");
    //scanf("%s", &eventreadinginst);
    
    NSLog(@"Händelsebeskrivningen ");
    scanf("%s", &eventdesc);
    
//    NSString *startdateforeventstart = [NSString stringWithCString:startdateforevent encoding:NSUTF8StringEncoding];
//    startdateforeventstart = [startdateforeventstart stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
//    NSString *starttimeofeventstart = [NSString stringWithCString:starttimeofevent encoding:NSUTF8StringEncoding];
//    starttimeofeventstart = [starttimeofeventstart stringByReplacingOccurrencesOfString:@"_" withString:@":"];
//    NSString *endtimeforeventend = [NSString stringWithCString:endtimeforevent encoding:NSUTF8StringEncoding];
//    endtimeforeventend = [endtimeforeventend stringByReplacingOccurrencesOfString:@"_" withString:@":"];
    NSString *classroomev = [NSString stringWithCString:classroom encoding:NSUTF8StringEncoding];
    NSString *altteachereve = [NSString stringWithCString:altteacher encoding:NSUTF8StringEncoding];
    NSString *eventreadinginsteve = [NSString stringWithCString:eventreadinginst encoding:NSUTF8StringEncoding];
    NSString *eventdesceve = [NSString stringWithCString:eventdesc encoding:NSUTF8StringEncoding];
    
    CourseEvent *event = [CourseEvent courseEventWithStartDate:startDate  eventEndDate:endDate classRoom:classroomev alternetiveTeacher:altteachereve eventReadingInstructions:eventreadinginsteve eventDescription:eventdesceve];
    [activeCourse addCourseEvent:event];
    //NSLog(@"course from new event: %@", activeCourse);
    [resultDictionary setDictionary:[service saveToDb:[activeCourse updateCourseAsDictionary]]];
    
    [activeCourse setDb_courseRev:[resultDictionary valueForKey:@"rev"]];
    
}
-(void)addStudentToCourse:(Course*)activeCourse {
    //NSLog(@"activeCourse: %@", activeCourse);
    int studentindex = 1000;
    //NSLog(@"students here: %@",[activeCourse allStudents]);
    NSArray *simpleStudentList;
    //NSLog(@"Listan med alla studenter: %@", [self listAllStudentsSortedByName]);
    simpleStudentList = [self listAllStudentsSortedByName];
    for(User *simpleUser in simpleStudentList){
        NSLog(@"%@", [simpleUser simpleDescription]);
    }
    NSLog(@"Valj en student index... Starta at index 0");
    scanf("%d", &studentindex);
 
    int tempInt = [[self listAllStudentsSortedByName]count];
    
    NSLog(@"tempint:%d", tempInt);
    if(studentindex < tempInt){
        
        User *tempUser = [[self listAllStudentsSortedByName] objectAtIndex:studentindex];
        //[tempUser simpleDescription];
        [activeCourse addStudentToCourse:tempUser];
        [activeCourse updateCourse];    
        // add course to student
        [tempUser addCourseToUser:activeCourse];
        [tempUser updateUser];
        //NSLog(@"tempuser from addStudentToCourse: %@",tempUser);
    } else {
        NSLog(@"Det finns inget student med den index\n");
    }

}

-(void)editCourseEvent:(Course*)activeCourse{
    NSInteger i = 0;
    int indexOfEvent = 10;
    
    for(CourseEvent *event in [activeCourse allEvents]){
        
        NSLog(@"event: %@ (%ld)", [event eventStartDate], i);
        i++;
    }
    NSLog(@"vilken händelse du vill uppdatera? från 0 as i: %ld", i);
    scanf("%d", &indexOfEvent);
   
    NSLog(@"Ditt val: %@",[[activeCourse allEvents]objectAtIndex:indexOfEvent]);
    CourseEvent *tempEvent = [[activeCourse allEvents]objectAtIndex:indexOfEvent];
    //NSLog(@"Room number: %@", [tempEvent classRoom]);
    
    char roomN[40];
    char readInst[256];
    char evDesc[200];
    char altteach[200];
    
    NSString *readingInst;
    NSDate *newDate;
    NSString *roomnumber;
    NSString *eventdescr;
    NSString *alterTeacher;
    
    // menu to update event
    int inputUserMenue = 10;
    
    do {
        if (inputUserMenue != 9)
        {
            switch (inputUserMenue) {
                case 1:
                    newDate = [self requestEventDate];
                    [tempEvent setEventStartDate:newDate];
                    break;
                case 2:
                    newDate = [self requestEventDate];
                    [tempEvent setEventEndDate:newDate];
                    break;
                case 3:
                    NSLog(@"ange ny rumsnummer: ");
                    scanf("%s", &roomN);
                    roomnumber = [NSString stringWithCString:roomN encoding:NSUTF8StringEncoding];
                    [tempEvent setClassRoom:roomnumber];
                    break;
                case 4:
                    NSLog(@"In läsanvisning: ");
                    scanf("%s", &readInst);
                    readingInst = [NSString stringWithCString:readInst encoding:NSUTF8StringEncoding];
                    [tempEvent setEventReadingInstructions:readingInst];
                    break;
                case 5:
                    NSLog(@"Ange händelsebeskrivningen: ");
                    scanf("%s", &evDesc);
                      //NSLog(@"enter event description: ");
                      //scanf("%s", &evDesc);
                      eventdescr = [NSString stringWithCString:evDesc encoding:NSUTF8StringEncoding];
 //                   eventdescr = [self requestUserInputText:@"enter event description: "];
//                    [tempEvent setEventDescription:eventdescr];
                    break;
                case 6:
                    NSLog(@"Alternativt läraren: ");
                    scanf("%s", &altteach);
                    alterTeacher = [NSString stringWithCString:altteach encoding:NSUTF8StringEncoding];
                    [tempEvent setAlternativeTeacher:alterTeacher];
                    break;
                default:
                    break;
            }
        }
        
        NSLog(@"Uppdatera startdatum: 1\n");
        NSLog(@"Uppdatera Slutdatum: 2\n");
        NSLog(@"Uppdatera rumsnummer: 3\n"); 
        NSLog(@"Uppdatera Läsanvisning: 4\n");
        NSLog(@"Uppdatera händelse beskrivning: 5\n");
        NSLog(@"uppdatera alternativ läraren: 6\n");        
        NSLog(@"Spara alla: 9\n\n");
        
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
    
    [activeCourse sortCourseEvents];
    [activeCourse updateCourse];
                                          
}
//-(void)loadCourseData:(NSString*) courseid
//{
//   // CourseServices *courseService = [[CourseServices alloc]init];
//   // activeCourse = [Course courseFromDictionary:[courseService dictionaryFromDbJson:courseid]];//@"pedronygren@gmail.com"]];
//  //  NSLog(@"dict2: %@", [courseService dictionaryFromDbJson:courseid]);
//}

//-(void)loadAllData
//{
//    
//}
-(NSDate*)requestEventDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    char y[40];
    char t[40];
    
    NSLog(@"Ange datum (yyyy-mm-dd):");
    scanf("%s", &y);
    NSLog(@"Klockslag (hh:mm):");
    scanf("%s", &t);
    //        NSLog(@"Last Name");
    //        scanf("%s", &l);
    NSString *date = [NSString stringWithCString:y encoding:NSUTF8StringEncoding];
    NSString *time = [NSString stringWithCString:t encoding:NSUTF8StringEncoding];
    // NSLog(@"time:%@", time);
    NSString *datetime = [NSString stringWithFormat:@"%@ %@:00 +0000",date, time];
    //NSString *datetime = [NSString stringWithFormat:@"%@ %@:00 +0000",@"2010-05-22", time];
    
    NSDate *theDate = [NSDate dateWithString:datetime];
    
    //NSDate *theDate = [dateFormatter dateFromString:datetime];
    //NSLog(@"date object:%@", courseDate);
    return  theDate;
}
//-(NSString*) requestUserInputText:(NSString*) textToUser
//{
//    char *inputStr = malloc (MAX_NAME_SZ);
//    const char *displayText = [textToUser UTF8String];
//    //displayText = [textToUser 
//    
//    if (inputStr == NULL) {
//        printf ("No memory\n");
//        return @"No memory";
//    }
//    
//    /* Ask user for name. */
//    
//    printf(displayText);
//    printf("\n");
//    /* Get the name, with size limit. */
//    fgets (inputStr, MAX_NAME_SZ, stdin);
//    
//    /* Remove trailing newline, if there. */
//    if (inputStr[strlen (inputStr) - 1] == '\n')
//        inputStr[strlen (inputStr) - 1] = '\0';
//    
//    /* Say hello. */
//    NSString *text = [NSString stringWithCString:inputStr encoding:NSUTF8StringEncoding];
//    /* Free memory and exit. */
//    free (inputStr);
//    return text;
//}
-(User*) thisActiveUser
{
  return activeUser;
}
-(NSArray*)listAllCoursesSortedByName {
    
    NSMutableArray *tempAllSortedCourses = [NSMutableArray arrayWithArray:allCourses]; 
    //Sort array  
    NSSortDescriptor *sortAll = [NSSortDescriptor sortDescriptorWithKey:@"courseName" ascending:TRUE];
    NSArray *sortDecArray = [NSArray arrayWithObject:sortAll];
   // NSLog(@"listAllCoursesSortedByName: %@", [tempAllSortedCourses sortedArrayUsingDescriptors:sortDecArray]);

    return [tempAllSortedCourses sortedArrayUsingDescriptors:sortDecArray];
    
}

-(NSArray*)listAllStudentsSortedByName {
    
    NSMutableArray *tempAllSortedStudents = [NSMutableArray arrayWithArray:allUsers]; 
    //Sort array  
    NSSortDescriptor *sortAllByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:TRUE];
    NSSortDescriptor *sortAllByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE];

    NSArray *sortDecArray = [NSArray arrayWithObjects:sortAllByLastName, sortAllByName, nil];
    //NSLog(@"listAllStudentsSortedByName: %@", [tempAllSortedStudents sortedArrayUsingDescriptors:sortDecArray]);
    return [tempAllSortedStudents sortedArrayUsingDescriptors:sortDecArray];
    
}
@end
