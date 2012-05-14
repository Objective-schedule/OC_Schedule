//
//  main.m
//  Schedule


#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"
#import "CourseEvent.h"
#import "Services.h"
#import "MainApp.h"
//
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        MainApp *mainApp = [[MainApp alloc] init];
        User *myActiveUser;
        
        [mainApp initApp];
        [mainApp loadUserData:@"Test"];
        
        myActiveUser = [mainApp thisActiveUser];
        
        //[myActiveUser weeklyInstructions:20];
        [mainApp initMenu];
                          
        //        NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
//        
//        User *susan = [User userWithUserEmail:@"test@gmail.com" username:@"Test" lastName:@"Testsson" role:ATRoleStudent];
//        
//        Course *courseApputv = [Course courseWithCourseId:@"AppUtv2011" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
//        
//        Course *courseApputv2 = [Course courseWithCourseId:@"HTM1" coursename:@"HTML basic" coursedescription:@"Du lär dig allt om HTML och kommer att tjäna massor" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
        
      //  NSDate *date1 = [NSDateFormatter )]
        //Creating events
//        CourseEvent *lecture1 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-09"]] 
//                                        eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 11:15:00 +0000 ", @"2012-05-09"]] 
//                                                        classRoom:@"401" 
//                                                   alternetiveTeacher:@"" 
//                                             eventReadingInstructions:@"Read chap 1"];
//        
//        CourseEvent *lecture2 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 12:15:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-14"]] classRoom:@"402" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 4"]; 
//        
//        CourseEvent *lecture3 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-03"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-03"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
//        
//        CourseEvent *lecture4 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 2"]; 
//        
//        CourseEvent *lecture5 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 09:15:00 +0000 ", @"2012-05-10"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:15:00 +0000 ", @"2012-05-10"]] classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
//        
//        CourseEvent *lecture6 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 08:15:00 +0000 ", @"2012-05-15"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 13:15:00 +0000 ", @"2012-05-15"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 5"]; 
//        
//        CourseEvent *lecture7 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-14"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-14"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
//        
//         CourseEvent *lecture8 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-05-17"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-05-17"]] classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 6"]; 
//        
//        
//        CourseEvent *lecture2_1 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 10:00:00 +0000 ", @"2012-02-18"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00 +0000 ", @"2012-02-18"]] classRoom:@"503" alternetiveTeacher:@"" eventReadingInstructions:@"Obj chap 1"]; 
//        
//        CourseEvent *lecture2_2 = [CourseEvent courseEventWithStartDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 15:00:00 +0000 ", @"2012-02-18"]] eventEndDate:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 16:00:00 +0000 ", @"2012-02-18"]] classRoom:@"504" alternetiveTeacher:@"" eventReadingInstructions:@"Obj chap 2"]; 
        
        //Adding coursEvents to Course
//        [courseApputv addCourseEvent:lecture1];
//        [courseApputv addCourseEvent:lecture2];
//        [courseApputv addCourseEvent:lecture3];
//        [courseApputv addCourseEvent:lecture4];
//        [courseApputv addCourseEvent:lecture5];
//        [courseApputv addCourseEvent:lecture6];
//        [courseApputv addCourseEvent:lecture7];
//        [courseApputv addCourseEvent:lecture8];
        
        //Adding coursEvents to Course2
//        [courseApputv2 addCourseEvent:lecture2_1];
//        [courseApputv2 addCourseEvent:lecture2_2];
               
        //NSLog(@"%@", courseApputv);
        //NSLog(@"%@", lecture1);
        
        //NSLog(@"%@", susan);
//        User *pedro = [User userWithUserEmail:@"pedronygren@gmail.com" username:@"pedro20" lastName:@"nygren" role:ATRoleStudent];
//       
//        [courseApputv addStudentToCourse:pedro];
//        [pedro addCourseToUser:courseApputv];
//        
//        [courseApputv addStudentToCourse:susan];
//        [susan addCourseToUser:courseApputv];
//        
//        [courseApputv2 addStudentToCourse:pedro];
//        [pedro addCourseToUser:courseApputv2];

        //****List all students on courseApputv
        //NSLog(@"%@", [courseApputv allStudents]);
        
        //****List all courseEvents for student pedro 
        //NSLog(@"%@",[pedro allCourseEvents]); 
        
        //*** initiate deService
        //Services *dbService = [[Services alloc]init];
        
          //***get unice doc from DB
        //[dbService getUniqeDoc:@"2075c9bef00b28311ad7244b0d002480"];
        
        //***get all students from DB
        //[dbService getAllStudents];
        
        //**** Save student pedro to DB
        //[dbService saveToDb:[pedro saveUserAsDictionary]];
       
        //*** Save course to DB
        //[dbService saveToDb:[courseApputv2 asDictionary]];
       
        //*** List course and courseEvents as dictionary
         //NSLog(@"%@",[courseApputv asDictionary]);
        
        //*** show course startWeek and endWeek
        //NSLog(@"Start week: %ld End week: %ld",[courseApputv startWeek], [courseApputv endWeek]);
        
        //***Show weekly schema
       // NSLog(@"Veckoschema:\n%@", [pedro weeklySchema:0]);
        
        //***Show daily schema
        //NSLog(@"Dagschema:\n%@", [pedro dailySchema:[NSDate date]]);
       
         //***Show daily readinginstructions
        //[pedro dailyInstructions:[NSDate date]];
        
        //***Show weekly readinginstructions
        //[pedro weeklyInstructions:0];
                
    }
    return 0;
}

