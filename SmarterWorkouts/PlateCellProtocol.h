#import <Foundation/Foundation.h>

@class Plate;

@protocol PlateCellProtocol <NSObject>

- (void)plateBeganEditing:(Plate *)p;

- (void)plateEndEditing:(Plate *)plate;
@end