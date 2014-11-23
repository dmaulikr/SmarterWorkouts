#import <Foundation/Foundation.h>

@interface ActivityFilter : NSObject
+ (NSArray *)filter:(NSArray *)array forText:(NSString *)text;
@end