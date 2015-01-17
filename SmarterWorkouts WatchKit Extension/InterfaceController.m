//
//  InterfaceController.m
//  SmarterWorkouts WatchKit Extension
//
//  Created by Stefan Kendall on 12/3/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end



