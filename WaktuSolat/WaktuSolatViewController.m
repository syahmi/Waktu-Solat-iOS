//
//  WaktuSolatViewController.m
//  WaktuSolat
//
//  Created by Muhammad Syahmi Ismail on 3/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WaktuSolatViewController.h"
#import "KawasanViewController.h"
#import "SettingsViewController.h"

@interface WaktuSolatViewController ()

@end

@implementation WaktuSolatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"solat.plist"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"solat" ofType:@"plist"];

        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }
    
    waktuSolatLabel = [[NSMutableArray alloc] initWithObjects:@"Imsak", @"Subuh", @"Syuruk", @"Zohor", @"Asar", @"Maghrib", @"Isyak", nil];
    
    self.navigationController.toolbarHidden = NO;
    
    UIButton *sidebarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sidebarButton setFrame:CGRectMake(0, 0, 40, 22)];
    [sidebarButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [sidebarButton setImage:[UIImage imageNamed:@"sidebarButton.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:sidebarButton];

    self.navigationItem.leftBarButtonItem = leftButton;

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBackground.png"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];

    NSString *code = [data objectForKey:@"Code"] != nil ? [data objectForKey:@"Code"] : @"sgr03";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)displayData
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    waktuSolat = [[NSMutableArray alloc] initWithObjects:[data objectForKey:@"Imsak"], [data objectForKey:@"Subuh"], [data objectForKey:@"Syuruk"], [data objectForKey:@"Zohor"], [data objectForKey:@"Asar"], [data objectForKey:@"Maghrib"], [data objectForKey:@"Isyak"], nil];
    
    UITapGestureRecognizer *locationLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kawasan)];
    locationLabelGesture.numberOfTapsRequired = 1;
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:12];
    locationLabel.textColor = [UIColor whiteColor];
    locationLabel.shadowColor = [UIColor blackColor];
    locationLabel.shadowOffset = CGSizeMake(0, 1);
    locationLabel.textAlignment = UITextAlignmentCenter;
    locationLabel.numberOfLines = 2;
    locationLabel.lineBreakMode = UILineBreakModeWordWrap;
    locationLabel.text = [data objectForKey:@"Location"];
    [locationLabel setUserInteractionEnabled:YES];
    [locationLabel addGestureRecognizer:locationLabelGesture];
    
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithCustomView:locationLabel];
    
    [self.navigationController.toolbar setItems:[NSArray arrayWithObject:location]];
    
    // Custom titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake((320-200)/2, (44-34)/2, 200, 34)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Waktu Solat";
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [titleView addSubview:titleLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 14)];
    dateLabel.textAlignment = UITextAlignmentCenter;
    dateLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:11];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.text = [data objectForKey:@"Date"];
    dateLabel.shadowColor = [UIColor blackColor];
    dateLabel.shadowOffset = CGSizeMake(0, 1);
    [titleView addSubview:dateLabel];
    
    self.navigationItem.titleView = titleView;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [waktuSolat count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:1];
        cell.textLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:72/255.0 green:119/255.0 blue:60/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
    } if ([indexPath section] == 0) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"cellBackground.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
        if(indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"imsak.png"];
        } if(indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"subuh.png"];
        } if(indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"syuruk.png"];
        } if(indexPath.row == 3) {
            cell.imageView.image = [UIImage imageNamed:@"zohor.png"];
        } if(indexPath.row == 4) {
            cell.imageView.image = [UIImage imageNamed:@"asar.png"];
        } if(indexPath.row == 5) {
            cell.imageView.image = [UIImage imageNamed:@"maghrib.png"];
        } if(indexPath.row == 6) {
            cell.imageView.image = [UIImage imageNamed:@"isyak.png"];
        }
    }
    
    cell.textLabel.text = [waktuSolatLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [waktuSolat objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(IBAction)kawasan 
{
    KawasanViewController *kawasanViewController = [[KawasanViewController alloc] initWithNibName:@"KawasanViewController" bundle:nil];
    [self.navigationController pushViewController:kawasanViewController animated:YES];
}

-(IBAction)settings
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end