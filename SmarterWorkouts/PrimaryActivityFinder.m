#import "PrimaryActivityFinder.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"

@implementation PrimaryActivityFinder

+ (NSString *)primaryActivityFor:(Workout *)workout {
    SetGroup *setGroup = workout.setGroups[0];
    NSMutableDictionary *activityCounts = [@{} mutableCopy];
    if ([setGroup.sets count] == 0) {
        return nil;
    }

    for (Set *set in setGroup.sets) {
        NSNumber *count = activityCounts[set.activity];
        count = count ? count : @(0);
        activityCounts[set.activity] = count;
    }

    NSString *primaryActivity = (NSString *) [setGroup.sets[0] activity];
    for (NSString *activity in activityCounts) {
        if ([activityCounts[activity] intValue] > [activityCounts[primaryActivity] intValue]) {
            primaryActivity = activity;
        }
    }

    return primaryActivity;
}

@end