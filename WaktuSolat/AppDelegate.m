//
//  AppDelegate.m
//  WaktuSolat
//
//  Created by Sumardi Shukor on 2/25/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "AppDelegate.h"
#import "KawasanViewController.h"
#import "WaktuSolatViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize kawasanViewController = _kawasanViewController;
@synthesize waktuSolatViewController = _waktuSolatViewController;
@synthesize splashView = _splashView;
@synthesize rateApp = _rateApp;

- (void)dealloc
{
    [_window release];
    [_kawasanViewController release];
    [_waktuSolatViewController release];
    [_splashView release];
    [_rateApp release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    self.waktuSolatViewController = [[[WaktuSolatViewController alloc] initWithNibName:@"WaktuSolatViewController" bundle:nil] autorelease];
    
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:self.waktuSolatViewController] autorelease];
    
    // Add iOS 4.3 and below compatibilty
    
    if ([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
        [navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar_img.png"] forToolbarPosition:0 barMetrics:UIBarMetricsDefault];
    }
    
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:74/255.0 green:158/255.0 blue:55/255.0 alpha:1];
    navigationController.toolbar.tintColor = [UIColor colorWithRed:74/255.0 green:158/255.0 blue:55/255.0 alpha:1];
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"backButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    [_window addSubview:_kawasanViewController.view];
    [_window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:1.5];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self _rateApp];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)waktuSolat {
	// Handle the notificaton when the app is running
	NSLog(@"Received Notification %@",waktuSolat);
}

- (void)removeSplash
{
    [_splashView removeFromSuperview];
    [_splashView release];
}

#pragma mark - Rate Waktu Solat

- (void)_rateApp 
{
    int launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount"];
    launchCount++;
    [[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"launchCount"];
    
    BOOL neverRate = [[NSUserDefaults standardUserDefaults] boolForKey:@"neverRate"];
    
    if ((neverRate != YES) && (launchCount > 10)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying Waktu Solat?" message:@"If so, please rate this app on the App Store so we can keep the free updates coming." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes, rate it!", @"Never ask again", @"Remind me later", nil];
        alert.delegate = self;
        [alert show];
        [alert release];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/waktu-solat/id507750415?mt=8"]];
    } else if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
    } else if (buttonIndex == 2) {
        // Do nothing
    }
}

@end
