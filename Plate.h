#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Plate : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * units;

@end
