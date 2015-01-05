#import <Foundation/Foundation.h>

@class Plate;

@protocol PlateCellProtocol <NSObject>

- (void)plateBeganEditing:(Plate *)p;
@end