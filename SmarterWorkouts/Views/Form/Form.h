#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FormDelegate;
@class FormItemBarButtonItem;

@interface Form : NSObject

@property(nonatomic, strong) NSArray *fields;
@property(nonatomic, weak) NSObject <FormDelegate> *delegate;

- (instancetype)initWithFields:(NSArray *)fields;

- (FormItemBarButtonItem *)spacerButton;

- (FormItemBarButtonItem *)doneButton:(UITextField *)field;

- (void)setItems:(NSArray *)items forField:(UITextField *)field;
@end