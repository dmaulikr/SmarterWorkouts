#import <Foundation/Foundation.h>

@protocol ActivityFormDelegate <NSObject>
- (void)formCanceled;

- (void)formFinished:(NSArray *)sets;

- (void)formDelete;

- (void)formChangeToType:(NSString *)type withOptions:(NSDictionary *)options;

@end