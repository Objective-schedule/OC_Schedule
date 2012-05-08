//
//  User.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "Course.h"

extern NSString *const ATRoleStudent = @"Student";
extern NSString *const ATRoleTeacher = @"Teacher";
extern NSString *const ATRoleAdmin = @"Admin";

extern NSString *const ATUserStatusActive = @"Active";
extern NSString *const ATUserStatusInactive = @"Inactive";



@implementation User

{
   NSArray *userCourses; 
}



@synthesize userName = _userName, lastName = _lastName, userEmail = _userEmail,
userMessages = _userMessages, userRole = _userRole;

+(id)userWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastName role:(NSString*)role {
    return [[self alloc] initWithUserEmail:userEmail username:userName lastName:lastName role:ATRoleStudent];
}
-(id) init {
    return [self initWithUserEmail:@"no-user-email" username:@"no-username" lastName:@"no-userlastName" role:@"no-user-role"];
}

-(id)initWithUserEmail:(NSString*)userEmail username:(NSString*)userName lastName:(NSString*)lastname role:(NSString*)role {
    if(self = [super init]) {
        _userName = [userName copy];
        _lastName = [lastname copy];
        _userEmail = [userEmail copy];
        _userRole = [role copy];
         userCourses = [NSArray array];
    }
    return self;
}
-(NSString*) description {
    return [NSString stringWithFormat:@"%@, %@, %@, %@", self.userName, self.lastName, self.userEmail, self.userRole];
}
// create dictionary with user
-(NSDictionary*)saveUserAsDictionary {
    NSDictionary *dictionaryWithUser = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"name",self.lastName, @"lastName",self.userEmail, @"email", self.userRole, @"role", nil];
    return dictionaryWithUser;
}

-(void) addCourseToUser:(Course*) course
{
    
    //Init userCourses array when needed, instead of in init function?
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:userCourses];
    
    [newArray addObject:course];
          
    userCourses = newArray;

}


-(NSArray*) allCourseEvents
{
    NSMutableArray *allEvents = [NSMutableArray array];
    for(Course* course in userCourses)
    {
        for(CourseEvent *event in [course allEvents])
        {
            [allEvents addObject:event];
        }
    }
    
    //NSLog(@"%@", allEvents);
    return allEvents;
}

@end
