#import <Foundation/Foundation.h>

@interface DecimalNumbers : NSObject

+ (NSDecimalNumber *)parse:(NSString *)value;

+ (NSDecimalNumberHandler *)noRaise;

@end