#import "SWTestCase.h"
#import "ActivityWeightFormViewController.h"
#import "FlavorTextUITextField.h"

@interface ActivityWeightFormViewControllerTests : SWTestCase
@end


@implementation ActivityWeightFormViewControllerTests

- (void)testGetsLoggedSets {
    ActivityWeightFormViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormViewController" owner:self options:nil][0];
    XCTAssertNotNil(controller.setsInput);

    XCTAssertEqual([controller loggedSets], 1);
    [controller.setsInput setText:@"2"];
    XCTAssertEqual([controller loggedSets], 2);
    [controller.setsInput setText:@""];
    XCTAssertEqual([controller loggedSets], 1);
}

@end