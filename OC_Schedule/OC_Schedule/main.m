
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
              
        myActiveUser = [mainApp thisActiveUser];
                
    }
    return 0;
}

