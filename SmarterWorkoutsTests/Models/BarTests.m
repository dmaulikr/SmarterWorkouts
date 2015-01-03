#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "SWTestCase.h"
#import "Bar.h"

@interface BarTests : SWTestCase
@end

@implementation BarTests

- (void)testCreatesBarsForUnits {
    Bar *lbsBar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", @"lbs"]];
    XCTAssertEqualObjects(lbsBar.weight, [NSDecimalNumber decimalNumberWithString:@"45"]);

    Bar *kgBar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", @"kg"]];
    XCTAssertEqualObjects(kgBar.weight, [NSDecimalNumber decimalNumberWithString:@"20"]);
}

@end