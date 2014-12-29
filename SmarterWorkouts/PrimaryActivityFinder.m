#import "PrimaryActivityFinder.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "Activity.h"

@implementation PrimaryActivityFinder

+ (NSString *)primaryActivityFor:(Workout *)workout {
    SetGroup *setGroup = workout.setGroups[0];
    NSMutableDictionary *activityCounts = [@{} mutableCopy];
    if ([setGroup.sets count] == 0) {
        return nil;
    }

    for (Set *set in setGroup.sets) {
        NSNumber *count = activityCounts[set.activity.name];
        count = count ? count : @(0);
        activityCounts[set.activity.name] = count;
    }

    NSString *primaryActivity = [[setGroup.sets[0] activity] name];
    for (NSString *activity in activityCounts) {
        if ([activityCounts[activity] intValue] > [activityCounts[primaryActivity] intValue]) {
            primaryActivity = activity;
        }
    }

    return primaryActivity;
}

@end