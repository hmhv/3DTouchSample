//
//  AppDelegate.m
//  aaa
//
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic1" localizedTitle:@"title1" localizedSubtitle:@"sub1" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic2" localizedTitle:@"title2" localizedSubtitle:@"sub2" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause] userInfo:nil];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic3" localizedTitle:@"title3" localizedSubtitle:@"sub3" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];

    [[UIApplication sharedApplication] setShortcutItems: @[ item1, item2, item3 ]];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"%@-%@-%@", shortcutItem.type, shortcutItem.localizedTitle, shortcutItem.localizedSubtitle);
    
    completionHandler(YES);
}

@end
