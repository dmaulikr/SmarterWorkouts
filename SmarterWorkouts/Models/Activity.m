//
//  Activity.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "Activity.h"
#import "Set.h"


@implementation Activity

@dynamic name;
@dynamic archived;
@dynamic usesBar;
@dynamic personalRecord;
@dynamic units;
@dynamic type;

+ (Activity *)findByName:(NSString *)name {
    NSPredicate *nameMatchingPredicate = [NSPredicate predicateWithFormat:@"%K == %@", @"name", name];
    return [Activity MR_findFirstWithPredicate:
            [NSCompoundPredicate andPredicateWithSubpredicates:@[nameMatchingPredicate, [self notArchivedPredicate]]]];
}

+ (Activity *)findByName:(NSString *)name withContext:(NSManagedObjectContext *)context {
    NSPredicate *nameMatchingPredicate = [NSPredicate predicateWithFormat:@"%K == %@", @"name", name];
    return [Activity                                                                                  MR_findFirstWithPredicate:
            [NSCompoundPredicate andPredicateWithSubpredicates:@[nameMatchingPredicate, [self notArchivedPredicate]]] inContext:context];
}

+ (NSFetchedResultsController *)findAllByType {
    return [Activity MR_fetchAllGroupedBy:@"type" withPredicate:[self notArchivedPredicate] sortedBy:@"type,name" ascending:YES];
}

+ (NSFetchedResultsController *)findAllByTypeMatching:(NSString *)text {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", [text lowercaseString]];
    return [Activity                                                                          MR_fetchAllGroupedBy:@"type" withPredicate:
            [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate, [self notArchivedPredicate]]] sortedBy:@"type,name" ascending:YES];
}

+ (NSPredicate *)notArchivedPredicate {
    return [NSPredicate predicateWithFormat:@"%K == %d", @"archived", NO];
}

- (void)deleteEntity {
    Set *set = [Set MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"activity", self]];
    if (set) {
        self.archived = YES;
    }
    else {
        [self MR_deleteEntity];
    }
}

+ (Activity *)createWithName:(NSString *)name {
    NSPredicate *nameMatchingPredicate = [NSPredicate predicateWithFormat:@"%K == %@", @"name", name];
    Activity *existing = [Activity MR_findFirstWithPredicate:nameMatchingPredicate];
    if (existing) {
        if (existing.archived) {
            existing.archived = NO;
            return existing;
        }
        else {
            return nil;
        }
    }
    else {
        Activity *activity = [Activity MR_createEntity];
        activity.name = name;
        return activity;
    }
}

@end
