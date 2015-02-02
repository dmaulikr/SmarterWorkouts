#import <CloudKit/CloudKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "FriendUpdater.h"
#import "Friend.h"

@implementation FriendUpdater

+ (void)updateFriendsFromWorkouts:(NSArray *)workoutRecords {
    NSLog(@"%@", @"Updating friends");
    for (CKRecord *record in workoutRecords) {
        CKReference *reference = record[@"user"];
        NSString *recordNameForUser = reference.recordID.recordName;
        Friend *friend = [Friend MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"recordName", recordNameForUser]];
        friend.lastWorkoutDate = record[@"date"];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end