#import <MagicalRecord/MagicalRecord+Actions.h>
#import "FixtureLoader.h"
#import "Activity.h"
#import "NSManagedObject+MagicalAggregation.h"
#import "NSManagedObject+MagicalDataImport.h"

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

- (void)load {
    if ([Activity MR_countOfEntities] == 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"activities" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [Activity MR_importFromArray:json inContext:localContext];
        }                 completion:^(BOOL success, NSError *error) {
            self.loaded = YES;
        }];
    }
}

@end