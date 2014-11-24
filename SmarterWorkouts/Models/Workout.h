//
//  Workout.h
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SetGroup;

@interface Workout : NSManagedObject

@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *setGroups;
@end

@interface Workout (CoreDataGeneratedAccessors)

- (void)insertObject:(SetGroup *)value inSetGroupsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSetGroupsAtIndex:(NSUInteger)idx;
- (void)insertSetGroups:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSetGroupsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSetGroupsAtIndex:(NSUInteger)idx withObject:(SetGroup *)value;
- (void)replaceSetGroupsAtIndexes:(NSIndexSet *)indexes withSetGroups:(NSArray *)values;
- (void)addSetGroupsObject:(SetGroup *)value;
- (void)removeSetGroupsObject:(SetGroup *)value;
- (void)addSetGroups:(NSOrderedSet *)values;
- (void)removeSetGroups:(NSOrderedSet *)values;
@end
