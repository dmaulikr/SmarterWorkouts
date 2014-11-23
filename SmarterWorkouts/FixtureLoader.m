#import <MagicalRecord/MagicalRecord+Actions.h>
#import "FixtureLoader.h"
#import "Activity.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "NSManagedObject+MagicalAggregation.h"

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
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"activities" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [Activity MR_importFromArray:json inContext:context];
    }
}

@end