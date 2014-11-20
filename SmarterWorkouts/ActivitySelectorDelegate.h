#import <Foundation/Foundation.h>

@protocol ActivitySelectorDelegate <NSObject>
- (void)activitySelected:(NSString *)activity;
@end