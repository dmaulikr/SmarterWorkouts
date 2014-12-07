#import "SWTestCase.h"
#import "DurationDisplay.h"

@interface DurationDisplayTests : SWTestCase
@end

@implementation DurationDisplayTests

- (void)testMakesDisplay {
    XCTAssertEqualObjects([DurationDisplay displayHumanDurationFromSeconds:@(13)], @"13 secs");
    XCTAssertEqualObjects([DurationDisplay displayHumanDurationFromSeconds:@(61)], @"1 mins 1 secs");
    XCTAssertEqualObjects([DurationDisplay displayHumanDurationFromSeconds:@(3601)], @"1 hrs 1 secs");
}

@end