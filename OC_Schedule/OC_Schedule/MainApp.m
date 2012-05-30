
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
    activeUser = [User userFromDictionaryWithCourses:[userService dictionaryFromDbJson:userid]]; // refactor userFromDictionaryWithCourses to cover messages as well
    
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
    NSDictionary* adminAllCourses = [NSDictionary dictionaryWithDictionary:[service getAllCourses]];

    NSMutableArray* tempAllStudentsArray = [[NSMutableArray alloc]init];
    NSMutableArray* tempAllCoursesArray = [[NSMutableArray alloc]init];

    for (id allStudentsDictionary in [adminAllStudents valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempUser = [User userFromDictionary:[allStudentsDictionary valueForKey:@"key"]];
        
        //add ready object to temporary array
        [tempAllStudentsArray addObject:tempUser];// resultatet ifrån saveUserAsDictionary komm in hit ];
    }
    
    allUsers = tempAllStudentsArray;
    
    for (id allCoursesDictionary in [adminAllCourses valueForKey:@"rows"]){
        
        // calling the dictionary within the db object
        tempCourses = [Course courseFromDictionaryWithEvents:[allCoursesDictionary valueForKey:@"key"]];

        NSArray *courseStudents = [NSArray arrayWithArray:[[allCoursesDictionary valueForKey:@"key"] valueForKey:@"courseStudents"]];
        for(NSString *studentId in courseStudents){
            
            NSMutableArray *temp = [NSMutableArray arrayWithArray:allUsers];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"db_id == %@", studentId];
            NSLog(@"predicate: %@", [predicate description]);
            NSArray *toBeReclaimed = [temp filteredArrayUsingPredicate:predicate];
           
            if([toBeReclaimed count] > 0) {
                [tempCourses addStudentToCourse:[toBeReclaimed objectAtIndex:0]];
                [[toBeReclaimed objectAtIndex:0]addCourseToUser:tempCourses];
            }
        }

        //add ready object to temporary array
        [tempAllCoursesArray addObject:tempCourses];
    }
    
    allCourses = tempAllCoursesArray;
    //NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
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
        
        NSLog(@"\n\n");
        NSLog(@"Lista alla kurser: 1\n");
        NSLog(@"Lista alla studenter: 2\n");
        NSLog(@"Skapa ny kurs: 3\n");
        NSLog(@"Skapa ny student: 4\n");
        NSLog(@"Administrera kurs: 5\n");
        NSLog(@"Skapa meddelande: 6\n");
        NSLog(@"Logga ut: 7\n\n");
        scanf("%d", &inputUserMenue);
    } while (inputUserMenue != 9);
}

-(void) adminCourseMenu
{
   // NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   // NSInteger thisWeekNum = [[calendar components: NSWeekCalendarUnit fromDate:[NSDate date]] week];
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


//-(void)loadUserData:(NSString*) userid
//{   
//    UserServices *userService = [[UserServices alloc]init];
//    activeUser = [User userFromDictionaryWithCourses:[userService dictionaryFromDbJson:userid]];
//          
//    NSLog(@"\nVälkommen %@ %@", [activeUser userName], [activeUser lastName]);
//}
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
    email = [email stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSString *name = [NSString stringWithCString:n encoding:NSUTF8StringEncoding];
    name = [name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSString *lastName = [NSString stringWithCString:l encoding:NSUTF8StringEncoding];
    lastName = [lastName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    User *student = [User userWithUserEmail:email username:name lastName:lastName role:ATRoleStudent db_id:@"" db_rev:@"" status:ATUserStatusActive];
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service saveToDb:[student saveUserAsDictionary]]];
    
    // get back the id and rev to update the newly created user
    student.db_id = [resultDictionary valueForKey:@"id"];
    student.db_rev = [resultDictionary valueForKey:@"rev"];
}
-(void)newMessage {
    char t[255]; // title
    char co[255]; // content

    NSLog(@"Titel: ");
    scanf("%s", &t);
    
    NSLog(@"Innehåll");
    scanf("%s", &co);
    
    NSString *title = [NSString stringWithCString:t encoding:NSUTF8StringEncoding];
    title = [title stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    NSString *content = [NSString stringWithCString:co encoding:NSUTF8StringEncoding];
    content = [content stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
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
        
        // save message id in student object
        for (User *student in allUsers) {
            [student addMessageToUser:message];
        }
        NSLog(@"Meddelande har skickats till alla studenter!");
    } else{
        // get list of student and display so that i can choose index
        int studentindex = 1000;
        
        NSLog(@"List med alla studenter: %@", [self listAllStudentsSortedByName]);
        NSLog(@"Valj en student index... Starta at index 0");
        scanf("%d", &studentindex);
        
        User *tempUser = [[self listAllStudentsSortedByName] objectAtIndex:studentindex];
        [message addStudent:tempUser.db_id];
        
        NSMutableDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:[service  saveToDb:[message saveMessageAsDictionary]]];
        message.db_id = [resultDictionary valueForKey:@"id"];
        message.db_rev = [resultDictionary valueForKey:@"rev"];
    }
}
-(void)newCourse {
        
    char ci[100];//courseid
    char cn[100];//coursename
    char cd[256];//course description
    char cp[40];//course points
    char ct[100];//course teacher
    int numberOfBooks;//course litterature
    char book[100];
    
    NSMutableArray *litterature = [NSMutableArray array];
    
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
        NSString *bookName = [NSString stringWithCString:book encoding:NSUTF8StringEncoding];
        bookName = [bookName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        [litterature addObject:bookName];
    }
    
    NSString *courseid = [NSString stringWithCString:ci encoding:NSUTF8StringEncoding];
    courseid = [courseid stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *coursename = [NSString stringWithCString:cn encoding:NSUTF8StringEncoding];
    coursename = [coursename stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *coursedescription = [NSString stringWithCString:cd encoding:NSUTF8StringEncoding];
    coursedescription = [coursedescription stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *coursepoints = [NSString stringWithCString:cp encoding:NSUTF8StringEncoding];
    NSString *courseteacher = [NSString stringWithCString:ct encoding:NSUTF8StringEncoding];
    courseteacher = [courseteacher stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    Course *course = [Course courseWithCourseId:courseid coursename:coursename coursedescription:coursedescription coursepoints:coursepoints courseteacher:courseteacher courseLitterature:litterature db_courseId:@"" db_courseRev:@""];
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionaryWithDictionary:[service saveToDb:[course asDictionary]]];
    
    // get back the id and rev to update the newly created user
    course.db_courseId = [resultDictionary valueForKey:@"id"];
    course.db_courseRev = [resultDictionary valueForKey:@"rev"];
    char answer[10];
        
    NSLog(@"Vill du skapa evenemang för denna kurs: y / n ");
    scanf("%s", &answer);
    NSString *answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    
    if([answ isEqualToString:@"y"])
    {
        do {
            [self newCourseEvent:course];
            NSLog(@"Vill du skapa evenemang för denna kurs: y / n ");
            scanf("%s", &answer);
            answ = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
        } while ([answ isEqualToString:@"y"]);
    }
}

-(void)newCourseEvent:(Course*)activeCourse{

    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];

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
    NSLog(@"Ange Klassrummet:");
    scanf("%s", &classroom);
    NSLog(@"Alternativt läraren ");
    scanf("%s", &altteacher);
    NSLog(@"In läsanvisning: ");
    scanf("%s", &eventreadinginst);
    
    NSLog(@"Händelsebeskrivningen ");
    scanf("%s", &eventdesc);

    NSString *classroomev = [NSString stringWithCString:classroom encoding:NSUTF8StringEncoding];
    NSString *altteachereve = [NSString stringWithCString:altteacher encoding:NSUTF8StringEncoding];
    altteachereve = [altteachereve stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *eventreadinginsteve = [NSString stringWithCString:eventreadinginst encoding:NSUTF8StringEncoding];
    eventreadinginsteve = [eventreadinginsteve stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    NSString *eventdesceve = [NSString stringWithCString:eventdesc encoding:NSUTF8StringEncoding];
    eventdesceve = [eventdesceve stringByReplacingOccurrencesOfString:@"_" withString:@" "];

    CourseEvent *event = [CourseEvent courseEventWithStartDate:startDate  eventEndDate:endDate classRoom:classroomev alternetiveTeacher:altteachereve eventReadingInstructions:eventreadinginsteve eventDescription:eventdesceve];
    
    [activeCourse addCourseEvent:event];
    [resultDictionary setDictionary:[service saveToDb:[activeCourse updateCourseAsDictionary]]];
    [activeCourse setDb_courseRev:[resultDictionary valueForKey:@"rev"]];
    
}
-(void)addStudentToCourse:(Course*)activeCourse {

    int studentindex = 1000;

    NSArray *simpleStudentList;
    simpleStudentList = [self listAllStudentsSortedByName];
    
    for(User *simpleUser in simpleStudentList){
        NSLog(@"%@", [simpleUser simpleDescription]);
    }
    NSLog(@"Valj en student index... Starta at index 0");
    scanf("%d", &studentindex);
 
    int tempInt = [[self listAllStudentsSortedByName]count];
    
    if(studentindex < tempInt){
        
        User *tempUser = [[self listAllStudentsSortedByName] objectAtIndex:studentindex];
        
        if(![[activeCourse allStudents] containsObject:tempUser]){
            
            [activeCourse addStudentToCourse:tempUser];
            [activeCourse updateCourse];
            NSLog(@"something is up here!!");

        } else {
            NSLog(@"that students is already register for that course");
        }
        if(![[tempUser allCourses] containsObject:activeCourse]){
            
            [tempUser addCourseToUser:activeCourse];
            [tempUser updateUser];
            NSLog(@"something is up here!!");

        } else {
            NSLog(@"that course is already register for that student");

        }
        
    } else {
        NSLog(@"Det finns inget student med den index\n");
    }
}

-(void)editCourseEvent:(Course*)activeCourse {
    
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
                    readingInst = [readingInst stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                    [tempEvent setEventReadingInstructions:readingInst];
                    break;
                case 5:
                    NSLog(@"Ange händelsebeskrivningen: ");
                    scanf("%s", &evDesc);
                    eventdescr = [NSString stringWithCString:evDesc encoding:NSUTF8StringEncoding];
                    eventdescr = [eventdescr stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                    [tempEvent setEventDescription:eventdescr];
                    break;
                case 6:
                    NSLog(@"Alternativt läraren: ");
                    scanf("%s", &altteach);
                    alterTeacher = [NSString stringWithCString:altteach encoding:NSUTF8StringEncoding];
                    alterTeacher = [alterTeacher stringByReplacingOccurrencesOfString:@"_" withString:@" "];
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
    
    NSString *date = [NSString stringWithCString:y encoding:NSUTF8StringEncoding];
    NSString *time = [NSString stringWithCString:t encoding:NSUTF8StringEncoding];
    NSString *datetime = [NSString stringWithFormat:@"%@ %@:00 +0000",date, time];
    
    NSDate *theDate = [NSDate dateWithString:datetime];
    
    return  theDate;
}

-(User*) thisActiveUser
{
  return activeUser;
}
-(NSArray*)listAllCoursesSortedByName {
    
    NSMutableArray *tempAllSortedCourses = [NSMutableArray arrayWithArray:allCourses]; 
    //Sort array  
    NSSortDescriptor *sortAll = [NSSortDescriptor sortDescriptorWithKey:@"courseName" ascending:TRUE];
    NSArray *sortDecArray = [NSArray arrayWithObject:sortAll];

    return [tempAllSortedCourses sortedArrayUsingDescriptors:sortDecArray];    
}

-(NSArray*)listAllStudentsSortedByName {
    
    NSMutableArray *tempAllSortedStudents = [NSMutableArray arrayWithArray:allUsers]; 
    //Sort array  
    NSSortDescriptor *sortAllByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:TRUE];
    NSSortDescriptor *sortAllByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:TRUE];

    NSArray *sortDecArray = [NSArray arrayWithObjects:sortAllByLastName, sortAllByName, nil];

    return [tempAllSortedStudents sortedArrayUsingDescriptors:sortDecArray];
    
}
@end
