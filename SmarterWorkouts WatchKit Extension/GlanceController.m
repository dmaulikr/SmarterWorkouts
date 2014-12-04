//
//  GlanceController.m
//  SmarterWorkouts WatchKit Extension
//
//  Created by Stefan Kendall on 12/3/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import "GlanceController.h"

@implementation GlanceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
    }
    return self;
}

- (void)willActivate {
    [self.topPlateCount setText:@"6"];
    [self.topPlateWeight setText:@"45s"];
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end



