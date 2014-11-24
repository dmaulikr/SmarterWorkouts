//
//  Plate.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/23/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "Plate.h"
#import "NSManagedObject+MagicalFinders.h"


@implementation Plate

@dynamic weight;
@dynamic count;
@dynamic units;

+ (NSArray *)findAllSorted:(NSString *)units {
    return [Plate MR_findByAttribute:@"units" withValue:units andOrderBy:@"weight" ascending:NO];
}

+ (void)createPlateWithWeight:(NSDecimalNumber *)weight count:(int)count units:(NSString *)units {
    NSAssert(weight != nil, @"");
    NSAssert(units != nil, @"");
    Plate *plate = [Plate MR_createEntity];
    plate.weight = weight;
    plate.count = @(count);
    plate.units = units;
}

@end
