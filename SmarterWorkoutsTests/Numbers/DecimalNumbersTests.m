#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "DecimalNumbers.h"

@interface DecimalNumbersTests : XCTestCase
@end

@implementation DecimalNumbersTests

- (void)testParsesSimpleDecimal {
    XCTAssertEqual([[NSDecimalNumber decimalNumberWithString:@"123.5"] compare:[DecimalNumbers parse:@"123.5"]], 0);
    XCTAssertEqual([[NSDecimalNumber decimalNumberWithString:@"0.25"] compare:[DecimalNumbers parse:@"0.25"]], 0);
}

- (void)testParsesEmpty {
    XCTAssertEqual([[NSDecimalNumber zero] compare:[DecimalNumbers parse:@""]], 0);
}

- (void)testParsesNil {
    XCTAssertEqual([[NSDecimalNumber zero] compare:[DecimalNumbers parse:nil]], 0);
}

@end