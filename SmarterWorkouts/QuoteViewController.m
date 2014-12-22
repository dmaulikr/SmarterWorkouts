#import "QuoteViewController.h"

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useRandomQuote];
}

- (void)useRandomQuote {
    NSArray *quotes = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"json"]]
                                                      options:(NSJSONReadingOptions) kNilOptions error:nil];

    NSDictionary *quote = quotes[arc4random_uniform([quotes count])];
    [self.author setText:quote[@"author"]];
    [self.quote setText:quote[@"quote"]];
}

@end