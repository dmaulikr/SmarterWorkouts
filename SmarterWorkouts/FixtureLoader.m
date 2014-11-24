#import <MagicalRecord/MagicalRecord+Actions.h>
#import "FixtureLoader.h"
#import "Activity.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "NSManagedObject+MagicalAggregation.h"
#import "Plate.h"

@implementation FixtureLoader

+ (FixtureLoader *)instance {
    static FixtureLoader *loader = nil;
    @synchronized (self) {
        if (loader == nil) {
            loader = [self new];
        }
    }

    return loader;
}

- (void)loadData {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [self loadDataInContext:localContext];
    }                 completion:^(BOOL success, NSError *error) {
        self.loaded = YES;
    }];
}

- (void)loadDataInContext:(NSManagedObjectContext *)context {
    if ([Activity MR_countOfEntitiesWithContext:context] == 0) {
        [Activity MR_importFromArray:[self loadArrayFromFile:@"activities"] inContext:context];
    }

    if ([Plate MR_countOfEntitiesWithContext:context] == 0) {
        [Plate MR_importFromArray:[self loadArrayFromFile:@"plates"] inContext:context];
    }
}

- (NSArray *)loadArrayFromFile:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return json;
}

@end