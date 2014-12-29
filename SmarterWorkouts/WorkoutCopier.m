#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "WorkoutCopier.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "NSManagedObject+MagicalDataImport.h"

@implementation WorkoutCopier

+ (void)copy:(Workout *)src to:(Workout *)dest {
    for (Set *set in [src.setGroups[0] sets]) {
        Set *destSet = [Set MR_createEntity];
        destSet.activity = set.activity;
        destSet.units = set.units;
        destSet.weight = set.weight;
        destSet.comments = set.comments;
        destSet.duration = set.duration;
        destSet.reps = set.reps;
        [dest.setGroups[0] addSetsObject:destSet];
    }
}

@end