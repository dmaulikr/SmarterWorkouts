#import <CoreData/CoreData.h>
#import "ActivityCell.h"
#import "ActivityFormDelegate.h"
#import "Set.h"
#import "Activity.h"

@implementation ActivityCell

- (void)prepareForReuse {
    self.activity = nil;
    self.selectedSet = nil;
}

- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [self.deleteButton setHidden:YES];
}

- (void)setSetToCopy:(Set *)set {
}

- (void)setSelectedSet:(Set *)selectedSet {
    _selectedSet = selectedSet;
    [self.deleteButton setHidden:NO];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.activityFormDelegate formCanceled];
}

@end