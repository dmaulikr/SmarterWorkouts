#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Form : NSObject

@property(nonatomic, strong) NSArray *fields;

- (instancetype)initWithFields:(NSArray *)fields;

- (UIView *)findFirstResponder;
@end