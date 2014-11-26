#import "SWTestCase.h"
#import "ActivityWeightFormCell.h"
#import "FlavorTextUITextField.h"

@interface ActivityWeightFormViewControllerTests : SWTestCase
@end


@implementation ActivityWeightFormViewControllerTests

- (void)testGetsLoggedSets {
    ActivityWeightFormCell *controller = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormCell" owner:self options:nil][0];
    XCTAssertNotNil(controller.setsInput);

    XCTAssertEqual([controller loggedSets], 1);
    [controller.setsInput setText:@"2"];
    XCTAssertEqual([controller loggedSets], 2);
    [controller.setsInput setText:@""];
    XCTAssertEqual([controller loggedSets], 1);
}

- (void)testGetsLoggedReps {
    ActivityWeightFormCell *controller = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormCell" owner:self options:nil][0];
    XCTAssertNotNil(controller.repsInput);

    XCTAssertEqual([controller loggedReps], 1);
    [controller.repsInput setText:@"2"];
    XCTAssertEqual([controller loggedReps], 2);
    [controller.repsInput setText:@""];
    XCTAssertEqual([controller loggedReps], 1);
}

@end