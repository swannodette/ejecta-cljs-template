//
//  AppDelegate.m
//  EjectaCLJS
//
//  Created by David Nolen on 5/20/15.
//  Copyright (c) 2015 dnolen. All rights reserved.
//

#import "AppDelegate.h"
#import "EJJavaScriptView.h"
#import "EJAppViewController.h"
#import "ABYContextManager.h"
#import "ABYServer.h"

@interface AppDelegate ()
@property (strong, nonatomic) ABYContextManager* contextManager;
@property (strong, nonatomic) ABYServer* replServer;
@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Optionally set the idle timer disabled, this prevents the device from sleep when
    // not being interacted with by touch. ie. games with motion control.
    application.idleTimerDisabled = YES;
    
    [self loadViewControllerWithScriptAtPath:@"index.js"];
    
    EJJavaScriptView* appView = (EJJavaScriptView*)window.rootViewController.view;
    JSGlobalContextRef ctx = appView.jsGlobalContext;
    
    NSURL* compilerOutputDirectory = [[self privateDocumentsDirectory] URLByAppendingPathComponent:@"cljs-out"];
    [self createDirectoriesUpTo:compilerOutputDirectory];
    
    // Set up our context
    self.contextManager = [[ABYContextManager alloc] initWithContext:ctx
                                             compilerOutputDirectory:compilerOutputDirectory];
    [self.contextManager setupGlobalContext];
    [self.contextManager setUpExceptionLogging];
    [self.contextManager setUpConsoleLog];
    [self.contextManager setUpTimerFunctionality];
    [self.contextManager setUpAmblyImportScript];
    
    self.replServer = [[ABYServer alloc] initWithContext:self.contextManager.context
                                 compilerOutputDirectory:compilerOutputDirectory];
    BOOL successful = [self.replServer startListening];
    if (!successful) {
        NSLog(@"Failed to start REPL server.");
    } else {
        NSLog(@"Started REPL server.");
    }
    
    return YES;
}

- (void)loadViewControllerWithScriptAtPath:(NSString *)path {
    // Release any previous ViewController
    window.frame = UIScreen.mainScreen.bounds;
    window.rootViewController = nil;
    
    EJAppViewController *vc = [[EJAppViewController alloc] initWithScriptAtPath:path];
    window.rootViewController = vc;
    [window makeKeyWindow];
    //[vc release];
}

- (NSURL *)privateDocumentsDirectory
{
    NSURL *libraryDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    
    return [libraryDirectory URLByAppendingPathComponent:@"Private Documents"];
}

- (void)createDirectoriesUpTo:(NSURL*)directory
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[directory path]]) {
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:[directory path]
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error]) {
            NSLog(@"Can't create directory %@ [%@]", [directory path], error);
            abort();
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
