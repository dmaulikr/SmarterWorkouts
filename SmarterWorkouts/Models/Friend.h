#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Friend : NSManagedObject

@property(nonatomic, retain) NSString *recordName;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSDate *lastWorkoutDate;
@property(nonatomic, retain) NSString *lastWorkoutActivity;

@end
