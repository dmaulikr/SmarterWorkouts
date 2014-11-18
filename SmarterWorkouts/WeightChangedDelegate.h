#import <Foundation/Foundation.h>

@protocol WeightChangedDelegate <NSObject>
- (void)weightChanged:(NSDecimalNumber *)weight;

- (void)anotherFieldHasFocus;
@end