#import "NoteInputAccessoryView.h"
#import "TextSaved.h"

@implementation NoteInputAccessoryView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)saveTapped:(id)sender {
    [self.messageBox resignFirstResponder];
    [self.delegate textSaved:self.messageBox.text];
}

@end