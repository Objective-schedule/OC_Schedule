//
//  main.m
//  Schedule


#import <Foundation/Foundation.h>
#import "User.h"
#import "Course.h"
#import "CourseEvent.h"
#import "Services.h"
#import "UserServices.h"
#import "MainApp.h"
//
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        MainApp *mainApp = [[MainApp alloc] init];
        
        User *myActiveUser;
        
        [mainApp initApp];
        
        //[mainApp loadUserData:@"Test"]; still no
        
        myActiveUser = [mainApp thisActiveUser];
        
        //[myActiveUser weeklyInstructions:20]; still no
        [mainApp initMenu];

                
    }
    return 0;
}

