#import "ActivitySelectorViewController.h"

@implementation ActivitySelectorViewController

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
    NSLog(@"%@", searchController.searchBar.text);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end