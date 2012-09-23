//
//  AppDelegate.h
//  WaktuSolat
//
//  Created by Sumardi Shukor on 2/25/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KawasanViewController;
@class WaktuSolatViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) KawasanViewController *kawasanViewController;

@property (strong, nonatomic) WaktuSolatViewController *waktuSolatViewController;

@property (strong, nonatomic) UIImageView *splashView;

@property (strong, nonatomic) UIAlertView *rateApp;

@end
