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
        if (i == [self.fields count] - 1) {
            [self addItems:@[[self spacerButton], [self doneButton:field]] forField:field];
        }
        else {
            [self addItems:@[[self closeButton:field], [self spacerButton], [self nextButton:field]] forField:field];
        }
    }
}

- (FormItemBarButtonItem *)nextButton:(UITextField *)field {
    return [[FormItemBarButtonItem alloc] initWithTitle:@"Next"
                                                  style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(nextTapped:)
                                             parentView:field];
}

- (FormItemBarButtonItem *)spacerButton {
    return [[FormItemBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

- (FormItemBarButtonItem *)doneButton:(UITextField *)field {
    return [[FormItemBarButtonItem alloc] initWithTitle:@"Done"
                                                  style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(doneTapped:)
                                             parentView:field];
}

- (FormItemBarButtonItem *)closeButton:(UITextField *)field {
    return [[FormItemBarButtonItem alloc] initWithTitle:@"Close"
                                                  style:UIBarButtonItemStylePlain
                                                 target:self
                                                 action:@selector(closeTapped:)
                                             parentView:field];
}

- (void)addItems:(NSArray *)items forField:(UITextField *)field {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];
    toolbar.items = items;
    field.inputAccessoryView = toolbar;
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