#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "Plate.h"
#import "MagicalRecord.h"
#import "NSManagedObject+MagicalFinders.h"

@interface PlateTests : XCTestCase
@end

@implementation PlateTests

- (void)testHasPlatesForLbsAndKg {
    NSArray *plates = [Plate MR_findAll];
    XCTAssertTrue([plates count] > 0);
}

@end