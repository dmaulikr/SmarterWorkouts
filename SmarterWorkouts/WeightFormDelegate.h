#import <Foundation/Foundation.h>

@protocol WeightFormDelegate <NSObject>
- (void)weightChanged:(NSDecimalNumber *)weight;

- (void)weightDoneEditing;

- (void)formCanceled;

@end