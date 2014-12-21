//
//  Set.h
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Set : NSManagedObject

@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * reps;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSDecimalNumber * weight;

- (NSDictionary *)dictionary;
@end
