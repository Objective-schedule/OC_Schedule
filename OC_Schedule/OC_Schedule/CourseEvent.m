

#import "CourseEvent.h"
#import "Course.h"

@implementation CourseEvent

@synthesize classRoom = _classRoom, alternativeTeacher = _alternativeTeacher, eventStartDate = _eventStartDate, eventEndDate = _eventEndDate, eventReadingInstructions = _eventReadingInstructions, eventDescription = _eventDescription;


+(id)courseEventWithStartDate:(NSDate*) eventStartDate eventEndDate:(NSDate*) eventEndDate classRoom:(NSString*) classRoom alternetiveTeacher:(NSString*) alternativeTeacher  eventReadingInstructions:(NSString*) eventReadingInstructions eventDescription:(NSString*)eventDescription
                  
{
    return [[self alloc] initWithStartDate:eventStartDate eventEndDate:eventEndDate classRoom:classRoom alternetiveTeacher:alternativeTeacher eventReadingInstructions:eventReadingInstructions eventDescription:eventDescription];
}

-(id)init
{
    return [self initWithStartDate:[NSDate dateWithString:@"no-date"]  eventEndDate:[NSDate dateWithString:@"no-date"] classRoom:@"no-room" alternetiveTeacher:@"no-alternetive-teacher" eventReadingInstructions:@"no-reainginstructions" eventDescription:@"no-desc"];              
}

-(id)initWithStartDate:(NSDate*) eventStartDate eventEndDate:(NSDate*) eventEndDate classRoom:(NSString*) classRoom alternetiveTeacher:(NSString*) alternativeTeacher eventReadingInstructions:(NSString*) eventReadingInstructions eventDescription:(NSString*)eventDescription                            
{
    if(self = [super init]) 
    {
        _eventStartDate = [eventStartDate copy];
        _eventEndDate = [eventEndDate copy];
        _classRoom = [classRoom copy];
        _alternativeTeacher = [alternativeTeacher copy]; //Should be User object
        _eventReadingInstructions = [eventReadingInstructions copy];
        _eventDescription = [eventDescription copy];
        
    }
    return self;
}

-(NSDictionary*) asDictionary
{
    
    NSString* eventStartDateAsString = [[self eventStartDate]description];
    
    NSString* eventEndDateAsString = [[self eventEndDate]description];
    

    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:eventStartDateAsString, @"eventStartDate",
                                                                    eventEndDateAsString, @"eventEndDate",
                                                                    self.classRoom, @"classRoom",
                                        self.alternativeTeacher,@"alternativeTeacher",
                          self.eventReadingInstructions,@"eventReadingInstructions", 
                          self.eventDescription, @"eventDescription", nil]; 
    return data;
    
}
+(id)courseEventFromDictionary:(NSDictionary*)dictionaryWithEvent
{
    return [self courseEventWithStartDate:[NSDate dateWithString:[dictionaryWithEvent valueForKey:@"eventStartDate"]]
                     eventEndDate:[NSDate dateWithString:[dictionaryWithEvent valueForKey:@"eventEndDate"]]
                                classRoom:[dictionaryWithEvent valueForKey:@"classRoom"]
                       alternetiveTeacher:[dictionaryWithEvent valueForKey:@"alternativeTeacher"]
                 eventReadingInstructions:[dictionaryWithEvent valueForKey:@"eventReadingInstructions"]
                         eventDescription:[dictionaryWithEvent valueForKey:@"eventDescription"]];
            
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Lektion --> Datum: %@ Sluttid %@ Kurslokal: %@ Readinstruct: %@ \n EventDescription: %@", self.eventStartDate, self.eventEndDate, self.classRoom, self.eventReadingInstructions, self.eventDescription];
}

@end
