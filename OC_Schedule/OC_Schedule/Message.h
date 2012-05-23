//
//  Message.h
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic) NSDate *sentDate;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *createdBy;
@property(nonatomic, copy) NSString *db_id;
@property(nonatomic, copy) NSString *db_rev;

+(id)messageWithTitle:(NSString*)title sentDate:(NSDate*)sentDate content:(NSString*)content createdBy:(NSString*)createdBy db_id:(NSString*)db_id db_rev:(NSString*)db_rev;

-(id)initMessageWithTitle:(NSString*)title sentDate:(NSDate*)sentDate content:(NSString*)content createdBy:(NSString*)createdBy db_id:(NSString*)db_id db_rev:(NSString*)db_rev;

@end
