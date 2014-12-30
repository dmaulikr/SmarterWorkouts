//
//  Activity.h
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Activity : NSManagedObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSDecimalNumber *personalRecord;
@property(nonatomic, retain) NSString *units;
@property(nonatomic, retain) NSString *type;
@property(nonatomic) BOOL usesBar;
@property(nonatomic) BOOL archived;

+ (Activity *)findByName:(NSString *)name;

+ (Activity *)findByName:(NSString *)string withContext:(NSManagedObjectContext *)context;

+ (NSFetchedResultsController *)findAllByType;

+ (NSFetchedResultsController *)findAllByTypeMatching:(NSString *)text;

- (void)deleteEntity;

+ (Activity *)createWithName:(NSString *)name;

@end
