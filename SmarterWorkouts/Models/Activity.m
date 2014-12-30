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
    return [Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name", name]];
}

+ (Activity *)findByName:(NSString *)name withContext:(NSManagedObjectContext *)context {
    return [Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name", name] inContext:context];
}

+ (NSFetchedResultsController *)findAllByType {
    return [Activity MR_fetchAllGroupedBy:@"type" withPredicate:nil sortedBy:@"type,name" ascending:YES];
}

+ (NSFetchedResultsController *)findAllByTypeMatching:(NSString *)text {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", [text lowercaseString]];
    return [Activity MR_fetchAllGroupedBy:@"type" withPredicate:predicate sortedBy:@"type,name" ascending:YES];
}

@end
