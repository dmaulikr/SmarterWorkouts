#import <Foundation/Foundation.h>

@class Activity;

@protocol ActivityCreateController <NSObject>

- (void) addExtraInfo: (Activity *) activity;

@end