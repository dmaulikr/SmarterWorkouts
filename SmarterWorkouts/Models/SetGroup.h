#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CloudKitModel.h"

@class SetGroup;

@interface SetGroup : NSManagedObject <CloudKitModel>

@property(nonatomic, retain) NSNumber *duration;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSOrderedSet *setGroups;
@property(nonatomic, retain) NSOrderedSet *sets;

- (void)addSetsArray:(NSArray *)values;

- (void)insertSetsArray:(NSArray *)array atIndex:(NSUInteger)index;
@end

@interface SetGroup (CoreDataGeneratedAccessors)

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

- (void)insertObject:(NSManagedObject *)value inSetsAtIndex:(NSUInteger)idx;

- (void)removeObjectFromSetsAtIndex:(NSUInteger)idx;

- (void)insertSets:(NSArray *)value atIndexes:(NSIndexSet *)indexes;

- (void)removeSetsAtIndexes:(NSIndexSet *)indexes;

- (void)replaceObjectInSetsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;

- (void)replaceSetsAtIndexes:(NSIndexSet *)indexes withSets:(NSArray *)values;

- (void)addSetsObject:(NSManagedObject *)value;

- (void)removeSetsObject:(NSManagedObject *)value;

- (void)addSets:(NSOrderedSet *)values;

- (void)removeSets:(NSOrderedSet *)values;
@end
