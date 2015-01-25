//
//  SetGroup.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 11/22/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <CloudKit/CloudKit.h>
#import "SetGroup.h"
#import "Set.h"

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
    for (id value in [array reverseObjectEnumerator]) {
        [newSet insertObject:value atIndex:index];
    }
    [self setSets:newSet];
}

- (CKRecord *)toRecordWithParent:(CKRecordID *)parent {
    CKRecord *setGroup = [[CKRecord alloc] initWithRecordType:@"SetGroup" recordID:
            [[CKRecordID alloc] initWithRecordName:self.objectID.URIRepresentation.absoluteString]];
    setGroup[@"parent"] = [[CKReference alloc] initWithRecordID:parent action:CKReferenceActionDeleteSelf];
    setGroup[@"duration"] = self.duration;
    setGroup[@"name"] = self.name;
    setGroup[@"sets"] = [@[] mutableCopy];
    for (Set *set in self.sets) {
        [setGroup[@"sets"] addObject:[[CKReference alloc]                                   initWithRecordID:
                [[CKRecordID alloc] initWithRecordName:set.objectID.URIRepresentation.absoluteString] action:CKReferenceActionNone]];
    }

    setGroup[@"setGroups"] = [@[] mutableCopy];
    for (SetGroup *setGroupInner in self.setGroups) {
        [setGroup[@"setGroups"] addObject:[[CKReference alloc]                                        initWithRecordID:
                [[CKRecordID alloc] initWithRecordName:setGroupInner.objectID.URIRepresentation.absoluteString] action:CKReferenceActionNone]];
    }
    return setGroup;
}

- (NSArray *)allRecordsToSave:(CKRecordID *)parent {
    CKRecord *record = [self toRecordWithParent:parent];
    NSMutableArray *all = [@[record] mutableCopy];

    for (SetGroup *setGroup in self.setGroups) {
        for (CKRecord *setGroupRecord in [setGroup allRecordsToSave:record.recordID]) {
            [all addObject:setGroupRecord];
        }
    }
    for (Set *set in self.sets) {
        for (CKRecord *setRecord in [set allRecordsToSave:record.recordID]) {
            [all addObject:setRecord];
        }
    }
    return all;
}

@end
