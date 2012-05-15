//
//  MainApp.h
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User, Course, CourseEvent;

@interface MainApp : NSObject

//*NSArray *allStudents
@property User *activeUser;

-(void) initApp;
-(void) initMenu;

-(void)loadUserData:(NSString*) userid;

-(void)loadAllData;

-(User*) thisActiveUser;



@end
