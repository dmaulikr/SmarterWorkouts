#import "QuoteViewController.h"

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.quote setText:@""];
    [self.author setText:@""];
    [self useRandomQuote];
}

- (void)useRandomQuote {
    NSArray *quotes = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"json"]]
                                                      options:(NSJSONReadingOptions) kNilOptions error:nil];

    NSDictionary *quote = quotes[arc4random_uniform([quotes count])];
    [self.quote setText:[NSString stringWithFormat:@"“%@”", quote[@"quote"]]];
    [self.author setText:quote[@"author"]];
}

@end