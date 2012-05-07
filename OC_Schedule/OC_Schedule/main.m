//
//  main.m
//  Schedule


#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"
#import "CourseEvent.h"

//
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
        
    
        
        User *susan = [User userWithUserEmail:@"flaca007@gmail.com" username:@"Susan" lastName:@"Sarabia" role:ATRoleStudent];
        
        Course *courseApputv = [Course courseWithCourseId:@"AppUtv2011" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:400 courseteacher:@"Anders Carlsson" courseLitterature:litterature];
        
        CourseEvent *lecture1 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:9 eventStopTime:12 classRoom:@"401" alternetiveTeacher:@"" eventReadingInstructions:@"Läs kap 1" course:courseApputv];
        CourseEvent *lecture2 = [CourseEvent courseEventWithDate:[NSDate date] eventStartTime:13 eventStopTime:15 classRoom:@"402" alternetiveTeacher:@"" eventReadingInstructions:@"Läs kap 2" course:courseApputv];
        
        [courseApputv addCourseEvent:lecture1];
        [courseApputv addCourseEvent:lecture2];
               
        NSLog(@"%@", courseApputv);
        //NSLog(@"%@", lecture1);
        
        NSLog(@"%@", susan);
    }
    return 0;
}

