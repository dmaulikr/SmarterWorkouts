#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "WeightActivityEditViewController.h"
#import "Activity.h"

@interface WeightCreateViewControllerTests : SWTestCase
@end

@implementation WeightCreateViewControllerTests

- (void)testGetsActivityDataFromFields {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CreateEditActivityController" bundle:nil];
    WeightActivityEditViewController *createViewController = [sb instantiateViewControllerWithIdentifier:@"WeightCreateViewController"];

    UISwitch *usesBarSwitch = [[UISwitch alloc] init];
    UISegmentedControl *lbsKgSegment = [[UISegmentedControl alloc] initWithItems:@[@"lbs", @"kg"]];
    UITextField *maxField = [[UITextField alloc] init];
    createViewController.usesBar = usesBarSwitch;
    createViewController.lbsKgSegment = lbsKgSegment;
    createViewController.maxField = maxField;

    [createViewController.usesBar setOn:YES];
    [createViewController.lbsKgSegment setSelectedSegmentIndex:1];
    [createViewController.maxField setText:@"305"];

    Activity *activity = [Activity MR_createEntity];
    [createViewController addExtraInfo:activity];
    XCTAssertEqual(activity.usesBar, YES);
    XCTAssertEqualObjects(activity.units, @"kg");
    XCTAssertEqualObjects(activity.personalRecord, [NSDecimalNumber decimalNumberWithString:@"305"]);
}

@end