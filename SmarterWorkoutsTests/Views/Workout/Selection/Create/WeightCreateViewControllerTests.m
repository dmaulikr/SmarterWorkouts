#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SWTestCase.h"
#import "WeightCreateViewController.h"

@interface WeightCreateViewControllerTests : SWTestCase
@end

@implementation WeightCreateViewControllerTests

- (void)testGetsActivityDataFromFields {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CreateNewActivityViewController" bundle:nil];
    WeightCreateViewController *createViewController = [sb instantiateViewControllerWithIdentifier:@"WeightCreateViewController"];

    UISwitch *usesBarSwitch = [[UISwitch alloc] init];
    UISegmentedControl *lbsKgSegment = [[UISegmentedControl alloc] initWithItems:@[@"lbs", @"kg"]];
    UITextField *maxField = [[UITextField alloc] init];
    createViewController.usesBar = usesBarSwitch;
    createViewController.lbsKgSegment = lbsKgSegment;
    createViewController.maxField = maxField;

    [createViewController.usesBar setOn:YES];
    [createViewController.lbsKgSegment setSelectedSegmentIndex:1];
    [createViewController.maxField setText:@"305"];

    NSDictionary *data = [createViewController activityData];
    XCTAssertNotNil(data);
    XCTAssertEqualObjects(data[@"usesBar"], @(1));
    XCTAssertEqualObjects(data[@"units"], @"kg");
    XCTAssertEqualObjects(data[@"max"], [NSDecimalNumber decimalNumberWithString:@"305"]);
}

@end