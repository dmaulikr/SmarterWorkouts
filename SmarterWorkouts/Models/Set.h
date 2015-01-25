//
//  Set.h
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 12/28/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CloudKitModel.h"

@class Activity;

@interface Set : NSManagedObject <CloudKitModel>

@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * reps;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) Activity *activity;

@end
