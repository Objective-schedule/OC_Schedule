//
//  Message.m
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Message.h"
#import "User.h"
@implementation Message {
    NSArray *sentTo;
}

@synthesize title = _title, sentDate = _sentDate, content = _content, createdBy = _createdBy, db_id = _db_id, db_rev = _db_rev;

+(id)messageWithTitle:(NSString*)title sentDate:(NSDate*)sentDate content:(NSString*)content createdBy:(NSString*)createdBy db_id:(NSString*)db_id db_rev:(NSString*)db_rev  {
    return [[self alloc] initMessageWithTitle:title sentDate:sentDate content:content createdBy:createdBy db_id:db_id db_rev: db_rev];
}
-(id) init {
    return [self initMessageWithTitle:@"no-title" sentDate:nil content:@"no-content" createdBy:@"no-createdBy" db_id: @"" db_rev:@""];
}

-(id)initMessageWithTitle:(NSString*)title sentDate:(NSDate*)sentDate content:(NSString*)content createdBy:(NSString*)createdBy db_id:(NSString*)db_id db_rev:(NSString*)db_rev {
    if(self = [super init]) {
        
        _title = [title copy];
        _sentDate = [sentDate copy];
        _content = [content copy];
        _createdBy = [createdBy copy];
        _db_id = [db_id copy];
        _db_rev = [db_rev copy];
        sentTo = [NSArray array];
        
    }
    return self;
}
-(NSString*) description {
    //[self getCoursesIds];
    return [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", self.title, self.sentDate, self.content, self.createdBy, self.db_id, self.db_rev];
}


-(void)addStudent:(NSString*)student {
    NSMutableArray* newArray = [NSMutableArray arrayWithArray:sentTo];
    
    [newArray addObject:student];
    
    sentTo = newArray;
}
// create new dictionary with new user

-(NSDictionary*)saveMessageAsDictionary {
    
    // must save with time clock!!
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
    
    NSString *nowDate = [dateFormatter stringFromDate:[self sentDate]];
    NSDictionary *dictionaryWithMessage = [NSDictionary dictionaryWithObjectsAndKeys:self.title, @"title",nowDate, @"sentDate",self.content, @"content", self.createdBy, @"createdBy", sentTo, @"sentTo", nil];
    NSLog(@"dictionaryWithMessage: %@", dictionaryWithMessage);
    return dictionaryWithMessage;
}

@end
