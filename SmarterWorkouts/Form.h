#import <Foundation/Foundation.h>

@interface Form : NSObject

@property(nonatomic, strong) NSArray *fields;

- (instancetype)initWithFields:(NSArray *)fields;

@end