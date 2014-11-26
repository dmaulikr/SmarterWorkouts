#import <Foundation/Foundation.h>

@protocol WeightFormDelegate <NSObject>
- (void)formCanceled;

- (void)formFinished:(NSArray *)sets;

@end