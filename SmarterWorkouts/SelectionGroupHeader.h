#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SelectionGroupHeader : UIView {}
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

- (void)setType:(NSString *)name;
@end