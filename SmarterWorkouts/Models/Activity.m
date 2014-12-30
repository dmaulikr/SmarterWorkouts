//
//  Activity.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "Activity.h"


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
    return [Activity MR_findFirstWithPredicate:
            [NSCompoundPredicate andPredicateWithSubpredicates:@[nameMatchingPredicate, [self notArchivedPredicate]]]];
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

@end
