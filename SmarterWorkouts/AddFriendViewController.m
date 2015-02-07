#import <CloudKit/CloudKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "AddFriendViewController.h"
#import "Friend.h"
#import "AddFriendCell.h"
#import "CellRegister.h"

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [CellRegister registerClass:AddFriendCell.class for:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Add Friend";
    [self requestPermissionToFindFriends];
    [self.tableView setHidden:YES];
    [self.statusMessage setHidden:YES];
}

- (void)requestPermissionToFindFriends {
    [[CKContainer defaultContainer] requestApplicationPermission:CKApplicationPermissionUserDiscoverability
                                               completionHandler:^(CKApplicationPermissionStatus applicationPermissionStatus, NSError *error) {
                                                   if (applicationPermissionStatus == CKApplicationPermissionStatusGranted) {
                                                       [self findFriendsUsingApp];
                                                   }
                                                   else {
                                                       [self.statusMessage setHidden:NO];
                                                       [self.statusMessage setText:@"Oops! There was a problem searching for friends. Try again?"];
                                                   }
                                               }];
}

- (void)findFriendsUsingApp {
    CKDiscoverAllContactsOperation *operation = [CKDiscoverAllContactsOperation new];
    operation.queuePriority = NSOperationQueuePriorityHigh;
    operation.discoverAllContactsCompletionBlock = ^(NSArray *userInfos, NSError *operationError) {
                                                           self.contactsUsingApp = userInfos;
                                                           [self.findingFriendsLabel setHidden:YES];
                                                           [self.findingFriendsActivityIndicator setHidden:YES];
                                                           if ([self.contactsUsingApp count] == 0) {
                                                               [self.statusMessage setText:@"No friends found using the app. Invite someone through email?"];
                                                               [self.statusMessage setHidden:NO];
                                                           }
                                                           else {
                                                               [self.tableView setHidden:NO];
                                                               [self.tableView reloadData];
                                                           }
                                                       };
    [[CKContainer defaultContainer] addOperation:operation];
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
    return [[self contactsNotInFriends] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddFriendCell.class)];
    CKDiscoveredUserInfo *info = [self contactsNotInFriends][(NSUInteger) indexPath.row];
    [cell setUserInfo:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Friend *friend = [Friend MR_createEntity];
    CKDiscoveredUserInfo *info = self.contactsNotInFriends[(NSUInteger) indexPath.row];
    friend.name = [NSString stringWithFormat:@"%@ %@", info.firstName, info.lastName];
    friend.recordName = info.userRecordID.recordName;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Added!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

@end