#import "AppDelegate.h"
#import "MagicalRecord.h"
#import "MagicalRecord+Setup.h"
#import "FixtureLoader.h"
#import "SWTimer.h"
#import "Colors.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarTintColor:[Colors navBarColor]];
    [[UISearchBar appearance] setBarTintColor:[Colors navBarColor]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Workout"];
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