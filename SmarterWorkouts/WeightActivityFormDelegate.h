#import <Foundation/Foundation.h>

@protocol WeightActivityFormDelegate <NSObject>
- (void)formCanceled;

- (void)formFinished:(NSArray *)sets;

- (void)formDelete;

@end