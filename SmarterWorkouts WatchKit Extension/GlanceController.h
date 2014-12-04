//
//  GlanceController.h
//  SmarterWorkouts WatchKit Extension
//
//  Created by Stefan Kendall on 12/3/14.
//  Copyright (c) 2014 Stefan Kendall. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface GlanceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *bottomPlateCount;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *bottomPlateWeight;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *middleWeight;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *topPlateCount;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *middlePlateCount;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *topPlateWeight;

@end
