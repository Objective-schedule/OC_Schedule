
#import <Foundation/Foundation.h>


@interface CourseEvent : NSObject


@property(nonatomic, copy) NSString *classRoom;
@property(nonatomic, copy) NSString *alternativeTeacher;
@property(nonatomic) NSDate *eventStartDate;
@property(nonatomic) NSDate *eventEndDate;
@property(nonatomic, copy) NSString *eventReadingInstructions;
@property(nonatomic, copy) NSString *eventDescription;


+(id)courseEventWithStartDate:(NSDate*) eventStartDate eventEndDate:(NSDate*) eventEndDate classRoom:(NSString*) classRoom alternetiveTeacher:(NSString*) alternativeTeacher  eventReadingInstructions:(NSString*) eventReadingInstructions eventDescription:(NSString*)eventDescription;
                         

-(id)initWithStartDate:(NSDate*) eventStartDate eventEndDate:(NSDate*) eventEndDate classRoom:(NSString*) classRoom alternetiveTeacher:(NSString*) alternativeTeacher eventReadingInstructions:(NSString*) eventReadingInstructions eventDescription:(NSString*)eventDescription;                     


-(NSDictionary*) asDictionary;

+(id)courseEventFromDictionary:(NSDictionary*)dictionaryWithEvent;



@end
