//
//  SettingsViewController.h
//  WaktuSolat
//
//  Created by MSi on 7/31/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "KawasanViewController.h"
#import "WaktuSolatViewController.h"
#import "LicensesViewController.h"
#import "TSMiniWebBrowser.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIWindow *window;
    NSMutableArray *items;
}

@property (nonatomic, retain) IBOutlet UITableView *settingsView;

@end
