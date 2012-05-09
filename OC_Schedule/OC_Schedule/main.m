//
//  main.m
//  Schedule


#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"
#import "CourseEvent.h"
#import "Services.h"
//
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
        
    
        
        User *susan = [User userWithUserEmail:@"test@gmail.com" username:@"Test" lastName:@"Testsson" role:ATRoleStudent];
        
        Course *courseApputv = [Course courseWithCourseId:@"AppUtv2011" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
        
        Course *courseApputv2 = [Course courseWithCourseId:@"ObjectivC2011" coursename:@"Objective C" coursedescription:@"Du lär dig allt om Objective C och kommer att tjäna massor" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
        
        
        //Creating events
        CourseEvent *lecture1 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:9 eventStopTime:12 classRoom:@"401" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 1"];
        
        CourseEvent *lecture2 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:13 eventStopTime:15 classRoom:@"402" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 2"]; 
        
        CourseEvent *lecture3 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:13 eventStopTime:15 classRoom:@"403" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 3"]; 
        
        CourseEvent *lecture4 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:9 eventStopTime:15 classRoom:@"404" alternetiveTeacher:@"" eventReadingInstructions:@"Read chap 4"]; 
        
        
        CourseEvent *lecture2_1 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:13 eventStopTime:15 classRoom:@"503" alternetiveTeacher:@"" eventReadingInstructions:@"Obj chap 1"]; 
        
        CourseEvent *lecture2_2 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:9 eventStopTime:15 classRoom:@"504" alternetiveTeacher:@"" eventReadingInstructions:@"Obj chap 2"]; 
        
        //Adding coursEvents to Course
        [courseApputv addCourseEvent:lecture1];
        [courseApputv addCourseEvent:lecture2];
        [courseApputv addCourseEvent:lecture3];
        [courseApputv addCourseEvent:lecture4];
        
        //Adding coursEvents to Course2
        [courseApputv2 addCourseEvent:lecture2_1];
        [courseApputv2 addCourseEvent:lecture2_2];
               
       // NSLog(@"%@", courseApputv);
        //NSLog(@"%@", lecture1);
        
        //NSLog(@"%@", susan);
        User *pedro = [User userWithUserEmail:@"pedronygren@gmail.com" username:@"pedro3" lastName:@"nygren" role:ATRoleStudent];
       
        [courseApputv addStudentToCourse:pedro];
        [pedro addCourseToUser:courseApputv];
        
        [courseApputv addStudentToCourse:susan];
        [susan addCourseToUser:courseApputv];
        
        [courseApputv2 addStudentToCourse:pedro];
        [pedro addCourseToUser:courseApputv2];

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
        
                
    }
    return 0;
}

