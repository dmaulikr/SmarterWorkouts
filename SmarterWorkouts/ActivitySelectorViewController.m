#import <CoreData/CoreData.h>
#import "ActivitySelectorViewController.h"
#import "ActivitySelectorDelegate.h"
#import "Activity.h"
#import "NSManagedObject+MagicalFinders.h"
#import "SelectionGroupHeader.h"
#import "ActivitySearchCell.h"
#import "CellRegister.h"
#import "CreateNewActivityViewController.h"

@implementation ActivitySelectorViewController

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

- (void)viewDidLoad {
    self.navigationItem.title = @"Activities";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create New"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(addNew)];

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
    [CellRegister registerClass:ActivitySearchCell.class for:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.data = [Activity MR_fetchAllGroupedBy:@"type" withPredicate:nil sortedBy:@"type,name" ascending:YES];
    self.filteredData = self.data;
    [self.tableView reloadData];
}

- (void)addNew {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CreateNewActivityViewController" bundle:nil];
    CreateNewActivityViewController *createNewViewController = [sb instantiateInitialViewController];
    [self.searchController setActive:NO];
    [self.navigationController pushViewController:createNewViewController animated:YES];
}

- (void)cancel {
    [self.searchController setActive:NO];
    [self.navigationController popViewControllerAnimated:YES];
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
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.filteredData.sections[(NSUInteger) section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivitySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitySearchCell"];
    Activity *activity = [self.filteredData objectAtIndexPath:indexPath];
    [cell.activityLabel setText:activity.name];
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
    [self.delegate activitySelected:selectedActivity];
    [self.navigationController popViewControllerAnimated:YES];
}

@end