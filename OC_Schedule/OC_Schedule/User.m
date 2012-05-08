//
//  User.m
//  Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

extern NSString *const ATRoleStudent = @"Student";
extern NSString *const ATRoleTeacher = @"Teacher";
extern NSString *const ATRoleAdmin = @"Admin";

extern NSString *const ATUserStatusActive = @"Active";
extern NSString *const ATUserStatusInactive = @"Inactive";

@implementation User

@synthesize userName = _userName, lastName = _lastName, userEmail = _userEmail,
userCourses = _userCourses, userMessages = _userMessages, userRole = _userRole;

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
    }
    return self;
}
-(NSString*) description {
    return [NSString stringWithFormat:@"%@, %@, %@, %@", self.userName, self.lastName, self.userEmail, self.userRole];
}
// create dictionary with user
-(NSDictionary*)saveUserAsDictionary:(User*)user {
    NSDictionary *dictionaryWithUser = [NSDictionary dictionaryWithObjectsAndKeys:self.userName, @"name",self.lastName, @"lastName",self.userEmail, @"email", self.userRole, @"role", nil];
    return dictionaryWithUser;
}


@end
