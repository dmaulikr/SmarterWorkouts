//
//  SetGroup.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import "SetGroup.h"
#import "SetGroup.h"


@implementation SetGroup

@dynamic duration;
@dynamic name;
@dynamic setGroups;
@dynamic sets;

- (void)addSetsArray:(NSArray *)values {
    for(id value in values){
        [self addSetsObject:value];
    }
}


@end
