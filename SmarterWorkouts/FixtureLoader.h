#import <Foundation/Foundation.h>

@interface FixtureLoader : NSObject

@property(nonatomic) BOOL loaded;

- (void)load;

@end