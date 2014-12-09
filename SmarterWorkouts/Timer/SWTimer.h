#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TimerObserver;

@interface SWTimer : NSObject

@property(nonatomic) int secondsRemaining;

@property(nonatomic) NSTimer *timer;

@property(nonatomic, weak) NSObject <TimerObserver> *observer;

+ (instancetype)instance;

- (void)start:(int)seconds;

- (void)stopTimer;

- (void)endTimer;

- (void)suspend;

- (void)resume;

- (BOOL)isRunning;
@end