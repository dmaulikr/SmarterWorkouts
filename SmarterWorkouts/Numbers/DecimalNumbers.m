#import "DecimalNumbers.h"

@implementation DecimalNumbers

+ (NSDecimalNumber *)parse:(NSString *)value {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:value];
    if([number isEqual:[NSDecimalNumber notANumber]]){
        return [NSDecimalNumber zero];
    }
    return number;
}

@end