#import "BarCalculator.h"
#import "PlateRemaining.h"
#import "DecimalNumbers.h"
#import "Plate.h"

@interface BarCalculator ()
@property(nonatomic, strong) NSArray *plates;
@property(nonatomic) NSDecimalNumber *barWeight;
@end

@implementation BarCalculator

- (BarCalculator *)initWithPlates:(NSArray *)plates barWeight:(NSDecimalNumber *)barWeight {
    if (self = [super init]) {
        self.plates = plates;
        self.barWeight = barWeight;
    }
    return self;
}

- (NSArray *)platesToMakeWeight:(NSDecimalNumber *)weight {
    NSDecimalNumber *targetWeight = [weight decimalNumberBySubtracting:self.barWeight withBehavior:[DecimalNumbers noRaise]];
    NSArray *remainingPlates = [self copyPlates:self.plates];
    NSMutableArray *platesToMakeWeight = [@[] mutableCopy];

    NSArray *potentialSolution = nil;
    while ([targetWeight compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
        remainingPlates = [remainingPlates filteredArrayUsingPredicate:
                [NSPredicate predicateWithBlock:^BOOL(PlateRemaining *p, NSDictionary *bindings) {
                    return p.count > 0;
                }]];

        PlateRemaining *nextPlate = [self findPlateClosestToWeight:targetWeight fromPlates:remainingPlates];
        if (nextPlate == nil) {
            if ([targetWeight isEqual:[NSDecimalNumber zero]] || potentialSolution != nil) {
                break;
            }
            else {
                potentialSolution = [platesToMakeWeight copy];
                if ([potentialSolution count] > 0) {
                    NSDecimalNumber *lastPlateWeight = [potentialSolution lastObject];
                    targetWeight = [targetWeight                   decimalNumberByAdding:[lastPlateWeight decimalNumberByMultiplyingBy:
                            [NSDecimalNumber decimalNumberWithString:@"2"]] withBehavior:[DecimalNumbers noRaise]];
                    PlateRemaining *plateForWeight = [remainingPlates filteredArrayUsingPredicate:
                            [NSPredicate predicateWithBlock:^BOOL(PlateRemaining *p, NSDictionary *bindings) {
                                return [p.weight isEqual:lastPlateWeight];
                            }]][0];
                    plateForWeight.count = 0;
                    [platesToMakeWeight removeObject:lastPlateWeight];
                }
            }
        }
        else {
            [platesToMakeWeight addObject:nextPlate.weight];
            nextPlate.count -= 2;
            targetWeight = [targetWeight decimalNumberBySubtracting:
                    [nextPlate.weight decimalNumberByMultiplyingBy:
                            [NSDecimalNumber decimalNumberWithString:@"2"]]];
        }
    }

    return [self closestSolutionBetween:platesToMakeWeight and:potentialSolution forWeight:targetWeight];
}

- (NSArray *)closestSolutionBetween:(NSMutableArray *)solution1 and:(NSArray *)solution2 forWeight:(NSDecimalNumber *)weight {
    if (solution2 == nil) {
        return solution1;
    }

    NSDecimalNumber *solution1Sum = [self sum:solution1];
    NSDecimalNumber *solution2Sum = [self sum:solution2];

    NSDecimalNumber *solution1Diff = [weight decimalNumberBySubtracting:solution1Sum];
    NSDecimalNumber *solution2Diff = [weight decimalNumberBySubtracting:solution2Sum];

    return [solution1Diff compare:solution2Diff] == NSOrderedAscending ? solution1 : solution2;
}

- (NSDecimalNumber *)sum:(NSArray *)plates {
    NSDecimalNumber *sum = [NSDecimalNumber zero];
    for (NSDecimalNumber *plate in plates) {
        sum = [sum decimalNumberByAdding:
                        [plate decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]]
                            withBehavior:[DecimalNumbers noRaise]];
    }
    return sum;
}

- (PlateRemaining *)findPlateClosestToWeight:(NSDecimalNumber *)weight fromPlates:(NSArray *)plates {
    NSArray *closestPlates = [plates filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PlateRemaining *plate, NSDictionary *bindings) {
        NSComparisonResult comparison = [[plate.weight decimalNumberByMultiplyingBy:
                [NSDecimalNumber decimalNumberWithString:@"2"]] compare:weight];
        return comparison == NSOrderedSame || comparison == NSOrderedAscending;
    }]];

    if ([closestPlates count] == 0) {
        return nil;
    }
    return closestPlates[0];
}

- (NSArray *)copyPlates:(NSArray *)plates {
    NSMutableArray *platesRemaining = [@[] mutableCopy];
    for (Plate *p in plates) {
        [platesRemaining addObject:[PlateRemaining fromPlate:p]];
    }
    return platesRemaining;
}

@end