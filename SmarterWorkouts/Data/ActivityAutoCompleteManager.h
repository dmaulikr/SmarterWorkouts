#import <objc/NSObject.h>
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>

@interface ActivityAutoCompleteManager : NSObject <HTAutocompleteDataSource>
+ (ActivityAutoCompleteManager *)instance;
@end