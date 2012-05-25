//
//  UserServices.h
//  OC_Schedule
//
//  Created by Student vid Yrkeshögskola C3L on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Services.h"

@interface UserServices : Services
// all the different gets to db  goes here
-(NSDictionary*)dictionaryFromDbJson:(NSString*)dbId;
-(NSDictionary*)dictionaryFromMessageDbJson:(NSString*)dbId;

@end
