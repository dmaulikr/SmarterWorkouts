#import "Form.h"
#import "FormItemBarButtonItem.h"
#import "FormDelegate.h"

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

        FormItemBarButtonItem *closeButton = [[FormItemBarButtonItem alloc] initWithTitle:@"Close"
                                                                                    style:UIBarButtonItemStylePlain
                                                                                   target:self
                                                                                   action:@selector(closeTapped:)
                                                                               parentView:field];
        FormItemBarButtonItem *doneButton = [[FormItemBarButtonItem alloc] initWithTitle:@"Done"
                                                                                   style:UIBarButtonItemStyleDone
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
            items = @[closeButton, flexBarButton, nextButton];
        }

        toolbar.items = items;
        field.inputAccessoryView = toolbar;
    }
}

- (void)doneTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
}

- (void)closeTapped:(FormItemBarButtonItem *)fromField {
    [self.delegate closeButtonTapped];
}

- (void)nextTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
    NSUInteger index = [self.fields indexOfObject:fromField.parentView];
    if (index < [self.fields count] - 1) {
        [self.fields[index + 1] becomeFirstResponder];
    }
}

@end