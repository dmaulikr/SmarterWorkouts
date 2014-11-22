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
        if (i == 0 && field.inputAccessoryView != nil) {
            [self addItems:@[[self spacerButton], [self nextButton:field]] forField:field];
        }
        else if (i == [self.fields count] - 1) {
            [self setItems:@[[self previousButton:field], [self spacerButton], [self doneButton:field]] forField:field];
        }
        else if (i == 0) {
            [self setItems:@[[self spacerButton], [self nextButton:field]] forField:field];
        } else {
            [self setItems:@[[self previousButton:field], [self spacerButton], [self nextButton:field]] forField:field];
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

- (FormItemBarButtonItem *)previousButton:(UITextField *)field {
    return [[FormItemBarButtonItem alloc] initWithTitle:@"Previous"
                                                  style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(previousTapped:)
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

- (void)setItems:(NSArray *)items forField:(UITextField *)field {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];
    toolbar.items = items;
    field.inputAccessoryView = toolbar;
}

- (void)addItems:(NSArray *)items forField:(UITextField *)field {
    UIToolbar *toolbar = (UIToolbar *) field.inputAccessoryView;
    toolbar.items = [toolbar.items arrayByAddingObjectsFromArray:items];
}

- (void)doneTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
}

- (void)nextTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
    NSUInteger index = [self.fields indexOfObject:fromField.parentView];
    if (index < [self.fields count] - 1) {
        [self.fields[index + 1] becomeFirstResponder];
    }
}

- (void)previousTapped:(FormItemBarButtonItem *)fromField {
    [fromField.parentView resignFirstResponder];
    NSUInteger index = [self.fields indexOfObject:fromField.parentView];
    if (index >= 0) {
        [self.fields[index - 1] becomeFirstResponder];
    }
}


@end