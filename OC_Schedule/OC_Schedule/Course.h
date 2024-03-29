
#import <Foundation/Foundation.h>

@class CourseEvent;
@class User;
@class Services;
@interface Course : NSObject

@property(nonatomic, copy) NSString *courseDescription;
@property(nonatomic, copy) NSString *courseName;
@property(nonatomic, copy) NSString *courseId;
@property(nonatomic, copy) NSString *db_courseId;
@property(nonatomic, copy) NSString *db_courseRev;
@property(nonatomic, copy) NSString *coursePoints;
@property(nonatomic, copy) NSString *courseTeacher; //Should be a User instead
@property(nonatomic, copy) NSArray *courseLitterature;

+(id) courseFromDictionary:(NSDictionary*) dictionary;
+(id)courseWithCourseId:(NSString*)courseId coursename:(NSString*)courseName coursedescription:(NSString*)courseDescription coursepoints:(NSString*)coursePoints courseteacher:(NSString*)courseTeacher courseLitterature:(NSArray*)courseLitterature db_courseId:(NSString*)db_courseId db_courseRev:(NSString*)db_courseRev;
-(id)initWithCourseId:(NSString*)courseId coursename:(NSString*)courseName coursedescription:(NSString*)courseDescription coursepoints:(NSString*)coursePoints courseteacher:(NSString*)courseTeacher courseLitterature:(NSArray*)courseLitterature db_courseId:(NSString*)db_courseId db_courseRev:(NSString*)db_courseRev;
+(id)courseFromDictionaryWithEvents:(NSDictionary*)dictionaryWithEvents;
-(NSInteger)startWeek;
-(NSInteger)endWeek;
-(void) addCourseEvent:(CourseEvent*) newEvent;
-(void)sortCourseEvents;
-(NSDictionary*)asDictionary;
-(NSDictionary*)updateCourseAsDictionary;
-(void)updateCourse;
-(NSArray*)getEventsAsDictionarys;
-(NSArray*)getStudentsIds;
-(void)addStudentToCourse:(User*) user;
-(NSArray*) allEvents;
-(NSArray*) allStudents;
-(NSString*)simpleDescription;


@end
