//
//  SetGroup.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import "SetGroup.h"


@implementation SetGroup

@dynamic duration;
@dynamic name;
@dynamic setGroups;
@dynamic sets;

- (void)addSetsArray:(NSArray *)values {
    for (id value in values) {
        [self addSetsObject:value];
    }
}

- (void)insertSetsArray:(NSArray *)array atIndex:(NSUInteger)index {
    NSMutableOrderedSet *newSet = [self.sets mutableCopy];
    for(id value in [array reverseObjectEnumerator]){
        [newSet insertObject:value atIndex:index];
    }
    [self setSets:newSet];
}

@end
