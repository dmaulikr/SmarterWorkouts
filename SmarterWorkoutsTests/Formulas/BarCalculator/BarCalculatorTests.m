#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import "BarCalculator.h"
#import "Plate.h"
#import "PlateRemaining.h"
#import "SWTestCase.h"

@interface BarCalculatorTests : SWTestCase
@property(nonatomic, strong) BarCalculator *calculator;
@end

@implementation BarCalculatorTests
- (void)setUp {
    [super setUp];
    self.calculator = [[BarCalculator alloc] initWithPlates:[Plate findAllSorted:@"lbs"] barWeight:
            [NSDecimalNumber decimalNumberWithString:@"45"]];
}

- (void)testMakesSimpleWeight {
    NSArray *expected225 = @[@45.0, @45.0];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"225"]], expected225);


    NSArray *expected260 = @[@45.0, @45.0, @10.0, @5, @2.5];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"260"]], expected260);

    NSArray *expected180 = @[@45, @10, @10, @2.5];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"180"]], expected180);

    NSArray *expected900 = @[@45, @45, @45, @45, @45, @45, @45, @45, @45, @10, @10, @2.5];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"900"]], expected900);
}

- (void)testMakesCorrectWeightWhenSmallerPlatesGetCloser {
    [Plate MR_truncateAll];
    [Plate                                  createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"25"] count:6 units:@"kg"];
    [Plate                                  createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"20"] count:6 units:@"kg"];
    [Plate                                  createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"15"] count:6 units:@"kg"];
    [Plate                                  createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"10"] count:6 units:@"kg"];
    [Plate                                 createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"5"] count:6 units:@"kg"];
    [Plate                                   createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"2.5"] count:6 units:@"kg"];
    [Plate                                    createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"1.25"] count:6 units:@"kg"];
    [Plate                                 createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"1"] count:6 units:@"kg"];
    [Plate                                   createPlateWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"0.5"] count:6 units:@"kg"];

    NSArray *expected = @[@25, @25, @2.5, @1, @0.5];
    NSArray *actual = [[[BarCalculator alloc] initWithPlates:[Plate findAllSorted:@"kg"] barWeight:
            [NSDecimalNumber decimalNumberWithString:@"20"]]
            platesToMakeWeight:[NSDecimalNumber decimalNumberWithString:@"128"]];
    XCTAssertEqualObjects(expected, actual);
}

- (void)testCopyPlatesReturnsNewPlates {
    NSArray *copy = [self.calculator copyPlates:[Plate findAllSorted:@"lbs"]];
    NSPredicate *unitsPredicate = [NSPredicate predicateWithFormat:@"%K == %@", @"units", @"lbs"];
    XCTAssertEqual((int) [copy count], [Plate MR_countOfEntitiesWithPredicate:unitsPredicate]);
    XCTAssertTrue([copy[0] isKindOfClass:PlateRemaining.class]);
}

- (void)testCalculates70kg {
    self.calculator = [[BarCalculator alloc] initWithPlates:[Plate findAllSorted:@"kg"] barWeight:
            [NSDecimalNumber decimalNumberWithString:@"20"]];
    NSArray *expected70 = @[@20, @5];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"70"]], expected70);
}

- (void)testFindPlateClosestToWeightMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"45"]    count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"35"]    count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator       findPlateClosestToWeight:
            [NSDecimalNumber decimalNumberWithString:@"100"] fromPlates:plates];
    XCTAssertEqualObjects(p, plate45);
}

- (void)testFindPlateClosestToWeightMatchBelowTop {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"45"]    count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"35"]    count:6];
    PlateRemaining *plate25 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"25"]    count:6];
    NSArray *plates = @[
            plate45,
            plate35,
            plate25
    ];

    PlateRemaining *p = [self.calculator      findPlateClosestToWeight:
            [NSDecimalNumber decimalNumberWithString:@"60"] fromPlates:plates];
    XCTAssertEqualObjects(p, plate25);
}

- (void)testFindPlateClosestToWeightNoMatch {
    PlateRemaining *plate45 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"45"]    count:6];
    PlateRemaining *plate35 = [[PlateRemaining alloc] initWithWeight:
            [NSDecimalNumber decimalNumberWithString:@"355"]   count:6];
    NSArray *plates = @[
            plate45,
            plate35
    ];

    PlateRemaining *p = [self.calculator      findPlateClosestToWeight:
            [NSDecimalNumber decimalNumberWithString:@"25"] fromPlates:plates];
    XCTAssertNil(p);
}

- (void)testHandles310 {
    [Plate MR_truncateAll];
    [Plate createPlateWithWeight:[NSDecimalNumber decimalNumberWithString:@"45"] count:20 units:@"lbs"];
    [Plate createPlateWithWeight:[NSDecimalNumber decimalNumberWithString:@"25"] count:6 units:@"lbs"];
    [Plate createPlateWithWeight:[NSDecimalNumber decimalNumberWithString:@"10"] count:6 units:@"lbs"];
    [Plate createPlateWithWeight:[NSDecimalNumber decimalNumberWithString:@"5"] count:6 units:@"lbs"];
    [Plate createPlateWithWeight:[NSDecimalNumber decimalNumberWithString:@"2.5"] count:6 units:@"lbs"];

    self.calculator = [[BarCalculator alloc] initWithPlates:[Plate findAllSorted:@"lbs"] barWeight:
            [NSDecimalNumber decimalNumberWithString:@"45"]];
    NSArray *expected310 = @[@45, @45, @25, @10, @5, @2.5];
    XCTAssertEqualObjects([self.calculator platesToMakeWeight:
            [NSDecimalNumber decimalNumberWithString:@"310"]], expected310);
}
@end