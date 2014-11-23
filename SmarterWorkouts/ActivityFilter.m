#import "ActivityFilter.h"
#import "Activity.h"

@implementation ActivityFilter

+ (NSArray *)filter:(NSArray *)array forText:(NSString *)text {
    NSString *trimmedText = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([trimmedText isEqualToString:@""]){
        return array;
    }

    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Activity *activity, NSDictionary *bindings) {
        return [[activity.name lowercaseString] containsString:[trimmedText lowercaseString]];
    }]];
}

@end