#import <Foundation/Foundation.h>
#import "HTAutocompleteTextField.h"

@interface FlavorTextHTAutocompleteTextField : HTAutocompleteTextField

@property(nonatomic, strong) NSString *flavor;

- (void)addFlavor;

- (void)removeFlavor;
@end