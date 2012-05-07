//
//  main.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *litterature = [NSArray arrayWithObjects:@"Objective C programming guide",@"Bok 2 om objective c",nil];
        
    
        
        User *susan = [User userWithUserEmail:@"flaca007@gmail.com" username:@"Susan" lastName:@"Sarabia" role:ATRoleStudent];
        
        Course *courseApputv = [Course courseWithCourseId:@"AppUtv2011" coursename:@"Apputveckling för mobila enheter" coursedescription:@"Kursen går ut på att lära sig utveckla appar för mobila enheter som iPad, iPhone och Andriod enehter" coursepoints:[NSNumber numberWithInteger:400] courseteacher:@"Anders Carlsson" courseLitterature:litterature];
        
        
        NSLog(@"%@", courseApputv);
        
        NSLog(@"%@", susan);
    }
    return 0;
}

