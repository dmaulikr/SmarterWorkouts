#import <CloudKit/CloudKit.h>
#import "FriendsViewController.h"
#import "CellRegister.h"
#import "LoadingFriendsCell.h"
#import "AddFriendCell.h"
#import "NoFriendsCell.h"

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [CellRegister registerClass:AddFriendCell.class for:self.tableView];
    [CellRegister registerClass:LoadingFriendsCell.class for:self.tableView];
    [CellRegister registerClass:NoFriendsCell.class for:self.tableView];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Friends";

    self.contactsFound = NO;
    self.contactsUsingApp = @[];
    [self requestPermissionToFindFriends];
    [self.tableView reloadData];
}

- (void)requestPermissionToFindFriends {
    [[CKContainer defaultContainer] requestApplicationPermission:CKApplicationPermissionUserDiscoverability
                                               completionHandler:^(CKApplicationPermissionStatus applicationPermissionStatus, NSError *error) {
                                                   if (applicationPermissionStatus == CKApplicationPermissionStatusGranted) {
                                                       [[CKContainer defaultContainer] discoverAllContactUserInfosWithCompletionHandler:
                                                               ^(NSArray *userInfos, NSError *error) {
                                                                   self.contactsUsingApp = userInfos;
                                                                   self.contactsFound = YES;
                                                                   [self.tableView reloadData];
                                                               }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSUInteger friendsCount = [[self getFriends] count];
        return friendsCount == 0 ? 1 : friendsCount;
    }
    else {
        return self.contactsFound ? [self.contactsUsingApp count] : 1;
    }
}

- (NSArray *)getFriends {
    return @[];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([[self getFriends] count] == 0) {
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(NoFriendsCell.class)];
        }
        else {
            return nil;
        }
    }
    else {
        if (self.contactsFound) {
            AddFriendCell *addFriendCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddFriendCell.class)];
            CKDiscoveredUserInfo *info = self.contactsUsingApp[(NSUInteger) indexPath.row];
            [addFriendCell setUserInfo:info];
            return addFriendCell;
        }
        else {
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LoadingFriendsCell.class)];
        }
    }
}


@end