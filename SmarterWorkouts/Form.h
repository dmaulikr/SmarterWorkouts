#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FormDelegate;

@interface Form : NSObject

@property(nonatomic, strong) NSArray *fields;
@property(nonatomic, weak) NSObject <FormDelegate> *delegate;

- (instancetype)initWithFields:(NSArray *)fields;

@end