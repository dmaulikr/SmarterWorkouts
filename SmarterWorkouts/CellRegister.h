#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellRegister : NSObject

+ (void)registerClass:(Class)klass for:(UITableView *)tableView;
@end