#import "ActivitySelectorViewController.h"
#import "ActivitySelectorDelegate.h"
#import "Activity.h"
#import "NSManagedObject+MagicalFinders.h"
#import "ActivityFilter.h"

@implementation ActivitySelectorViewController

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

- (void)viewDidLoad {
    self.data = [Activity MR_findAllSortedBy:@"name" ascending:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitySearchItem"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivitySearchItem"];
    }
    Activity *activity = self.filteredData[(NSUInteger) indexPath.row];
    [cell.textLabel setText:activity.name];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterDataBy:[searchController.searchBar text]];
}

- (void)filterDataBy:(NSString *)text {
    self.filteredData = [ActivityFilter filter:self.data forText:text];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate activitySelected:self.filteredData[(NSUInteger) indexPath.row]];
    }];
}

@end