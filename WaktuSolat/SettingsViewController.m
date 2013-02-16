//
//  SettingsViewController.m
//  WaktuSolat
//
//  Created by MSi on 7/31/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize settingsView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *section1 = [NSArray arrayWithObjects:@"Date Format", @"12H Time Format", nil];
    NSArray *section2 = [NSArray arrayWithObjects:@"License", @"Support", nil];
    NSArray *section3 = [NSArray arrayWithObjects:@"Follow on Twitter", @"Review on iTunes", @"Visit our Website", nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    items = [[NSMutableArray alloc] initWithObjects:section1, section2, section3, nil];
    window = [[UIApplication sharedApplication] keyWindow];
    
    self.navigationItem.title = @"Settings";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.settingsView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_settings.png"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[items objectAtIndex:section] count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
//            KawasanViewController *location = [[KawasanViewController alloc] initWithNibName:@"KawasanViewController" bundle:nil];
//            [self.navigationController pushViewController:location animated:YES];
        } else if(indexPath.row == 1) {
            /* Add some function here */
        }
    } if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            LicensesViewController *license = [[LicensesViewController alloc] init];
            [self.navigationController pushViewController:license animated:YES];
        } else if(indexPath.row == 1) {
            [self showEmailModalView];
        }
    } else if(indexPath.section == 2) {
        if(indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=waktuSolatApp"]];
        } if(indexPath.row == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/my/app/waktu-solat/id507750415?mt=8"]];
        } if(indexPath.row == 2) {
            TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:@"http://www.waktusolatapp.com"]];
            webBrowser.barStyle = UIBarStyleBlack;
            webBrowser.showURLStringOnActionSheetTitle = NO;
            [self.navigationController pushViewController:webBrowser animated:YES];
        }

    }
    
    NSIndexPath *tableSelection = [self.settingsView indexPathForSelectedRow];
    [self.settingsView deselectRowAtIndexPath:tableSelection animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.settingsView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cells"];
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];
        cell.textLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } if ([indexPath section] == 0) {
        if(indexPath.row == 1) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cells"];
            cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];
            cell.textLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            switchView.onTintColor = [UIColor colorWithRed:74/255.0 green:158/255.0 blue:55/255.0 alpha:1];
            [switchView addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchView;
            [switchView setOn:YES];
        }
    }
    cell.textLabel.text = [[items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)updateSwitchAtIndexPath:(id)sender
{
    UISwitch *switchView = (UISwitch *) sender;
    
    if (switchView.on) {
        [switchView setOn:YES animated:YES];
        NSLog(@"Open");
    } else {
        [switchView setOn:NO animated:YES];
        NSLog(@"Close");
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"About Waktu Solat";
    else
        return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 320, 20)];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    titleLabel.textColor = [UIColor colorWithRed:72/255.0 green:119/255.0 blue:60/255.0 alpha:1];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (void)showEmailModalView
{
	if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Waktu Solat: Support"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"syahmi@outlook.com", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
	
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}


@end