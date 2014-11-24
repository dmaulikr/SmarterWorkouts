#import <Foundation/Foundation.h>

@protocol WeightFormDelegate <NSObject>
- (void)weightChanged:(NSDecimalNumber *)weight;

- (void)formCanceled;

- (void)formFinished:(NSArray *)sets;

@end