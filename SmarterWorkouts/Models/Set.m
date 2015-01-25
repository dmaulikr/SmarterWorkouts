//
//  Set.m
//  SmarterWorkouts
//
//  Created by Stefan Kendall on 12/28/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <CloudKit/CloudKit.h>
#import "Set.h"
#import "Activity.h"


@implementation Set

@dynamic comments;
@dynamic duration;
@dynamic reps;
@dynamic units;
@dynamic weight;
@dynamic activity;

- (CKRecord *)toRecordWithParent:(CKRecordID *)parent {
    CKRecord *set = [[CKRecord alloc] initWithRecordType:@"Set" recordID:
            [[CKRecordID alloc] initWithRecordName:self.objectID.URIRepresentation.absoluteString]];
    set[@"parent"] = [[CKReference alloc] initWithRecordID:parent action:CKReferenceActionDeleteSelf];
    set[@"comments"] = self.comments;
    set[@"duration"] = self.duration;
    set[@"reps"] = self.reps;
    set[@"units"] = self.units;
    set[@"weight"] = self.weight;
    set[@"activity"] = self.activity ? [self.activity name] : @"";
    return set;
}

- (NSArray *)allRecordsToSave:(CKRecordID *)parent {
    return @[[self toRecordWithParent:parent]];
}

@end
