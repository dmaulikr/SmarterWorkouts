#import <CloudKit/CloudKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "FriendsViewController.h"
#import "CellRegister.h"
#import "LoadingFriendsCell.h"
#import "AddFriendCell.h"
#import "NoFriendsCell.h"
#import "Friend.h"
#import "FriendCell.h"
#import "FriendUpdater.h"

const int CONTACTS_SECTION = 1;

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [CellRegister registerClass:AddFriendCell.class for:self.tableView];
    [CellRegister registerClass:LoadingFriendsCell.class for:self.tableView];
    [CellRegister registerClass:NoFriendsCell.class for:self.tableView];
    [CellRegister registerClass:FriendCell.class for:self.tableView];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Friend" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
}

- (void)addFriend {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Friends";

    self.contactsFound = NO;
    self.contactsUsingApp = @[];
    [self requestPermissionToFindFriends];
    [self findFriendsLatestWorkout];
    [self.tableView reloadData];
}

- (void)findFriendsLatestWorkout {
    NSArray *allFriends = [Friend MR_findAll];
    NSMutableArray *predicates = [@[] mutableCopy];
    for (Friend *friend in allFriends) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"%K == %@", @"user",
                                                               [[CKRecordID alloc] initWithRecordName:friend.recordName]]];
    }
    if ([predicates count] > 0) {
        CKQuery *friendWorkoutQuery = [[CKQuery alloc] initWithRecordType:@"Workout" predicate:
                [NSCompoundPredicate orPredicateWithSubpredicates:predicates]];

        [[[CKContainer defaultContainer] publicCloudDatabase] performQuery:friendWorkoutQuery inZoneWithID:nil completionHandler:
                ^(NSArray *results, NSError *error) {
                    [FriendUpdater updateFriendsFromWorkouts:results];
                    [self.tableView reloadData];
                }];
    }
}

- (void)requestPermissionToFindFriends {
    [[CKContainer defaultContainer] requestApplicationPermission:CKApplicationPermissionUserDiscoverability
                                               completionHandler:^(CKApplicationPermissionStatus applicationPermissionStatus, NSError *error) {
                                                   if (applicationPermissionStatus == CKApplicationPermissionStatusGranted) {
                                                       CKDiscoverAllContactsOperation *operation = [CKDiscoverAllContactsOperation new];
                                                       operation.queuePriority = NSOperationQueuePriorityHigh;
                                                       operation.discoverAllContactsCompletionBlock = ^(NSArray *userInfos, NSError *operationError) {
                                                           self.contactsUsingApp = userInfos;
                                                           self.contactsFound = YES;
                                                           [self.tableView reloadData];
                                                       };
                                                       [[CKContainer defaultContainer] addOperation:operation];
                                                   }
                                                   else {
                                                       self.contactsFound = YES;
                                                   }
                                               }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"Friends", @"Contacts"][(NSUInteger) section];
}

- (NSArray *)contactsNotInFriends {
    return [self.contactsUsingApp filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
            ^BOOL(CKDiscoveredUserInfo *info, NSDictionary *bindings) {
                NSArray *matching = [Friend MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@",
                                                                                                     @"recordName",
                                                                                                     info.userRecordID.recordName]];
                return [matching count] == 0;
            }]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSUInteger friendsCount = [[self getFriends] count];
        return friendsCount == 0 ? 1 : friendsCount;
    }
    else {
        return self.contactsFound ? [self.contactsNotInFriends count] : 1;
    }
}

- (NSArray *)getFriends {
    return [Friend MR_findAll];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([[self getFriends] count] == 0) {
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(NoFriendsCell.class)];
        }
        else {
            FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FriendCell.class)];
            [cell setFriend:[self getFriends][(NSUInteger) indexPath.row]];
            return cell;
        }
    }
    else {
        if (self.contactsFound) {
            AddFriendCell *addFriendCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddFriendCell.class)];
            CKDiscoveredUserInfo *info = self.contactsNotInFriends[(NSUInteger) indexPath.row];
            [addFriendCell setUserInfo:info];
            return addFriendCell;
        }
        else {
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LoadingFriendsCell.class)];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CONTACTS_SECTION && self.contactsFound) {
        Friend *friend = [Friend MR_createEntity];
        CKDiscoveredUserInfo *info = self.contactsNotInFriends[(NSUInteger) indexPath.row];
        friend.name = [NSString stringWithFormat:@"%@ %@", info.firstName, info.lastName];
        friend.recordName = info.userRecordID.recordName;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.tableView reloadData];
    }
}


@end