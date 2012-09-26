//
//  SideMenuViewController.m
//  WaktuSolat
//
//  Created by MSi on 9/24/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "WaktuSolatViewController.h"

@implementation SideMenuViewController

#pragma mark - UITableViewDataSource

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBackground.png"]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sidebarCell.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]] autorelease];
        cell.selectedBackgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"sidebarCellSelected.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];
        cell.textLabel.shadowOffset = CGSizeMake(0, 0.5);
    } if(indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"Main"];
        cell.imageView.image = [UIImage imageNamed:@"icnHome.png"];
    } if(indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"Location"];
        cell.imageView.image = [UIImage imageNamed:@"icnGeolocation.png"];
    } if(indexPath.row == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"Qibla"];
        cell.imageView.image = [UIImage imageNamed:@"icnQibla.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"proBadge.png"]];
        imageView.frame = CGRectMake(90, 13, 47, 24);
        [cell.contentView addSubview:imageView];
        [imageView release];
    } if(indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"Notifications"];
        cell.imageView.image = [UIImage imageNamed:@"icnNotification.png"];
    } if(indexPath.row == 4) {
        cell.textLabel.text = [NSString stringWithFormat:@"Settings"];
        cell.imageView.image = [UIImage imageNamed:@"icnSettings.png"];
    } if(indexPath.row == 5) {
        cell.textLabel.text = [NSString stringWithFormat:@"Source Code"];
        cell.imageView.image = [UIImage imageNamed:@"icnCode.png"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0) {
        WaktuSolatViewController *waktuSolatView = [[WaktuSolatViewController alloc] initWithNibName:@"WaktuSolatViewController" bundle:nil];
        [self.navigationController pushViewController:waktuSolatView animated:YES];
        
        NSArray *controllers = [NSArray arrayWithObject:waktuSolatView];
        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    } else if(indexPath.row == 1) {
        KawasanViewController *location = [[KawasanViewController alloc] initWithNibName:@"KawasanViewController" bundle:nil];
        [self.navigationController pushViewController:location animated:YES];
        
        NSArray *controllers = [NSArray arrayWithObject:location];
        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    } else if(indexPath.row == 4) {
        SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:settings animated:YES];
        
        NSArray *controllers = [NSArray arrayWithObject:settings];
        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    } else if(indexPath.row == 5) {
        TSMiniWebBrowser *sourceCode = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:@"https://github.com/wutmedia/WaktuSolat"]];
        sourceCode.barStyle = UIBarStyleBlack;
        sourceCode.showURLStringOnActionSheetTitle = NO;
        [self.navigationController pushViewController:sourceCode animated:YES];
        
        NSArray *controllers = [NSArray arrayWithObject:sourceCode];
        [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
        [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    }
}

@end
