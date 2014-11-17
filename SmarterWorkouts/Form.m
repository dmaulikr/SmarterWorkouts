#import "Form.h"
#import "FormItemBarButtonItem.h"

@implementation Form

- (instancetype)initWithFields:(NSArray *)fields {
    self = [super init];
    if (self) {
        self.fields = fields;
        [self bindViewsWithToolbar];
    }

    return self;
}

- (void)bindViewsWithToolbar {
    for (NSUInteger i = 0; i < [self.fields count]; i++) {
        UITextField *field = self.fields[i];
        UIToolbar *toolbar = [UIToolbar new];
        [toolbar sizeToFit];

        NSArray *items = nil;

        FormItemBarButtonItem *doneButton = [[FormItemBarButtonItem alloc] initWithTitle:@"Done"
                                                                                   style:UIBarButtonItemStylePlain
                                                                                  target:self
                                                                                  action:@selector(doneTapped:)
                                                                              parentView:field];
        FormItemBarButtonItem *flexBarButton = [[FormItemBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        FormItemBarButtonItem *nextButton = [[FormItemBarButtonItem alloc] initWithTitle:@"Next"
                                                                                   style:UIBarButtonItemStyleDone
                                                                                  target:self
                                                                                  action:@selector(nextTapped:)
                                                                              parentView:field];

        if (i == [self.fields count] - 1) {
            items = @[flexBarButton, doneButton];
        }
        else {
            items = @[doneButton, flexBarButton, nextButton];
        }

        toolbar.items = items;
        field.inputAccessoryView = toolbar;
    }
}

- (void)doneTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
}

- (void)nextTapped:(FormItemBarButtonItem *)fromField {


}

@end