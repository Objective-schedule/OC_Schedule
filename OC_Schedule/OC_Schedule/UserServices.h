
#import "Services.h"

@interface UserServices : Services

-(NSDictionary*)dictionaryFromDbJson:(NSString*)dbId;
-(NSArray*)dictionaryFromMessageDbJson:(NSString*)dbId;

@end
