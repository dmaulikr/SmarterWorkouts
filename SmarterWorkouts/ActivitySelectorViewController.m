#import <CoreData/CoreData.h>
#import "ActivitySelectorViewController.h"
#import "ActivitySelectorDelegate.h"
#import "Activity.h"
#import "NSManagedObject+MagicalFinders.h"
#import "SelectionGroupHeader.h"

@implementation ActivitySelectorViewController

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

- (void)viewDidLoad {
    self.data = [Activity MR_fetchAllGroupedBy:@"type" withPredicate:nil sortedBy:@"type,name" ascending:YES];
    self.filteredData = self.data;
    self.navigationItem.title = @"Choose an Activity";

    UIBarButtonItem *cancelButton =
            [[UIBarButtonItem alloc] initWithTitle:@"cancel"
                                             style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(cancel)];

    self.navigationItem.leftBarButtonItem = cancelButton;

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;

    [self.searchController.searchBar sizeToFit];
    [self.searchController setDelegate:self];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.filteredData sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"a";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SelectionGroupHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"SelectionGroupHeader"
                                                                  owner:self options:nil] lastObject];
    id <NSFetchedResultsSectionInfo> sectionInfo = self.filteredData.sections[(NSUInteger) section];
    [header setType:sectionInfo.name];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.filteredData.sections[(NSUInteger) section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitySearchItem"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivitySearchItem"];
    }
    Activity *activity = [self.filteredData objectAtIndexPath:indexPath];
    [cell.textLabel setText:activity.name];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterDataBy:[searchController.searchBar text]];
}

- (void)filterDataBy:(NSString *)text {
    if (text.length == 0) {
        self.filteredData = self.data;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", [text lowercaseString]];
        self.filteredData = [Activity MR_fetchAllGroupedBy:@"type" withPredicate:predicate sortedBy:@"type,name" ascending:YES];
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Activity *selectedActivity = [self.filteredData objectAtIndexPath:indexPath];
    [self.searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate activitySelected:selectedActivity];
    }];
}

@end