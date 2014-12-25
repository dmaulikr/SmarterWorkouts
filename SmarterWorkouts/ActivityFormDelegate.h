#import <Foundation/Foundation.h>

@protocol ActivityFormDelegate <NSObject>
- (void)formCanceled;

- (void)formFinished:(NSArray *)sets;

- (void)formChangeToType:(NSString *)type withOptions:(NSDictionary *)options;

@end