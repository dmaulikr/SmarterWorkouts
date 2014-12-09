#import "AppDelegate.h"
#import "MagicalRecord.h"
#import "MagicalRecord+Setup.h"
#import "FixtureLoader.h"
#import "SWTimer.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Workout"];
    [[FixtureLoader instance] loadData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[SWTimer instance] suspend];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[SWTimer instance] resume];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

@end