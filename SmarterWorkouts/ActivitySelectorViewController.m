#import "ActivitySelectorViewController.h"
#import "ActivitySelectorDelegate.h"

@implementation ActivitySelectorViewController

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }

    return self;
}

+ (instancetype)controllerWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate {
    return [[self alloc] initWithDelegate:delegate];
}


- (void)viewDidLoad {
    self.data = @[@"Bench", @"Deadlift", @"Rest", @"Squat"];
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
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitySearchItem"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivitySearchItem"];
    }
    [cell.textLabel setText:self.data[(NSUInteger) indexPath.row]];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate activitySelected:self.data[(NSUInteger) indexPath.row]];
    [self.searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end