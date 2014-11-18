#import "FlavorTextHTAutocompleteTextField.h"

@implementation FlavorTextHTAutocompleteTextField

- (void)addFlavor {
    NSString *text = self.text;
    if([text isEqualToString:@""]){
        return;
    }

    [self setText:[NSString stringWithFormat:@"%@ %@", text, self.flavor]];
}

- (void)removeFlavor {
    if ([self.text containsString:self.flavor]) {
        [self setText:[self.text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" %@", self.flavor] withString:@""]];
    }
}

@end