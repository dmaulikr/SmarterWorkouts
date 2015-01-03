#import <Foundation/Foundation.h>

@protocol UnitsChangedDelegate <NSObject>

- (void)unitsChanged:(NSString *)selectedUnits;

@end