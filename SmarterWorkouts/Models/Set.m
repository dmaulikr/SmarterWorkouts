#import "Set.h"
#import "NotNil.h"

@implementation Set

@dynamic activity;
@dynamic comments;
@dynamic duration;
@dynamic reps;
@dynamic units;
@dynamic weight;

- (NSDictionary *)dictionary {
    return @{@"activity" : [NotNil notNil: self.activity],
            @"comments" : [NotNil notNil: self.comments],
            @"duration" : [NotNil notNil: self.duration],
            @"reps" : [NotNil notNil: self.reps],
            @"units" : [NotNil notNil: self.units],
            @"weight" : [NotNil notNil: self.weight]};
}

@end
