#import <CloudKit/CloudKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "FriendsViewController.h"
#import "CellRegister.h"
#import "LoadingFriendsCell.h"
#import "NoFriendsCell.h"
#import "Friend.h"
#import "FriendCell.h"
#import "FriendUpdater.h"
#import "UIViewController+LoadStoryBoard.h"
#import "AddFriendViewController.h"

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [CellRegister registerClass:LoadingFriendsCell.class for:self.tableView];
    [CellRegister registerClass:NoFriendsCell.class for:self.tableView];
    [CellRegister registerClass:FriendCell.class for:self.tableView];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Friend" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
}

- (void)addFriend {
    [self loadStoryboard:NSStringFromClass(AddFriendViewController.class)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"Friends";

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Friends";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger friendsCount = [[Friend MR_findAll] count];
    return friendsCount == 0 ? 1 : friendsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[Friend MR_findAll] count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(NoFriendsCell.class)];
    }
    else {
        FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FriendCell.class)];
        [cell setFriend:[Friend MR_findAll][(NSUInteger) indexPath.row]];
        return cell;
    }
}

@end