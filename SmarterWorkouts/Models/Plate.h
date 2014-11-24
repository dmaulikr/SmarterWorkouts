#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Plate : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * units;

+ (NSArray *)findAllSorted:(NSString *)string;

+ (void)createPlateWithWeight:(NSDecimalNumber *)weight count:(int)count units:(NSString *)units;
@end
