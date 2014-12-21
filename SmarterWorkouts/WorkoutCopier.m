#import "WorkoutCopier.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "NSManagedObject+MagicalDataImport.h"

@implementation WorkoutCopier

+ (void)copy:(Workout *)src to:(Workout *)dest {
    NSMutableArray *setData = [@[] mutableCopy];
    for (Set *set in [src.setGroups[0] sets]) {
        [setData addObject:[set dictionary]];
    }

    [dest.setGroups[0] addSetsArray:[Set MR_importFromArray:setData]];
}

@end