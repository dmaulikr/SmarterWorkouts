#import "NotNil.h"

@implementation NotNil

+ (id)notNil:(id)value {
    return value == nil ? [NSNull null] : value;
}

@end