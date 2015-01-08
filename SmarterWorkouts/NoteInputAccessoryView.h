#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TextSaved;

@interface NoteInputAccessoryView : UIView <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *messageBox;
@property(weak, nonatomic) NSObject <TextSaved> *delegate;

@end