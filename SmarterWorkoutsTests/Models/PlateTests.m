#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "Plate.h"
#import "NSManagedObject+MagicalFinders.h"
#import "SWTestCase.h"

@interface PlateTests : SWTestCase
@end

@implementation PlateTests

- (void)testHasPlatesForLbsAndKg {
    NSArray *plates = [Plate MR_findAll];
    XCTAssertTrue([plates count] > 0);
}

- (void)testSortsPlates {
    NSArray *plates = [Plate findAllSorted:@"lbs"];
    Plate *plate1 = plates[0];
    Plate *plate2 = plates[1];
    XCTAssertEqualObjects(plate1.weight, [NSDecimalNumber decimalNumberWithString:@"45"]);
    XCTAssertEqualObjects(plate2.weight, [NSDecimalNumber decimalNumberWithString:@"35"]);
}

@end