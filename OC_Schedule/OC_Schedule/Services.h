//
//  Services.h
//  db
//
//  Created by Student vid Yrkeshögskola C3L on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Services : NSObject


@property(nonatomic, copy) NSString *databaseAddress;

// create json from dictionary
-(NSData*)createJsonFromDictionary:(NSDictionary*)dictionary;
-(void)saveToDb:(NSDictionary*)dict;
//post a user to db
-(void)postUserToDb:(NSData*)jsonWithUser;

-(void)getAllStudents;
-(void)getUniqeDoc:(NSString*) dbId;

@end
