#import <Foundation/Foundation.h>

@interface FixtureLoader : NSObject

@property(nonatomic) BOOL loaded;

+ (FixtureLoader *)instance;

- (void)loadData;

- (void)loadDataInContext:(NSManagedObjectContext *)context;
@end