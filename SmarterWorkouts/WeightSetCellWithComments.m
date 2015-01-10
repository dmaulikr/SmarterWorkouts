#import "WeightSetCellWithComments.h"
#import "Set.h"

@implementation WeightSetCellWithComments

- (void)setSet:(Set *)set {
    [super setSet:set];
    [self.commentsLabel setText:set.comments];
}

@end