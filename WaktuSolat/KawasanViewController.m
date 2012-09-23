//
//  ViewController.m
//  WaktuSolat
//
//  Created by Sumardi Shukor on 2/25/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "KawasanViewController.h"

@interface KawasanViewController ()

@end

@implementation KawasanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"eSolat" ofType:@"plist"];
    
    kawasan = [[NSDictionary alloc] initWithDictionary:[[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"eSolat"]];

    NSArray *sortedKeys = [[kawasan allKeys] sortedArrayUsingSelector:@selector(compare:)];
    sortedKawasan = [[NSMutableArray alloc] init];
    for (NSString *key in sortedKeys) {
        [sortedKawasan addObject:key];
    }
    
    self.navigationItem.title = @"Location";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBackground.png"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sortedKawasan count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[kawasan objectForKey:[sortedKawasan objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sortedKawasan objectAtIndex:section];
}

- (void)dealloc
{
    [kawasan release];
    [sortedKawasan release];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundView = [ [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cellBackgroundLocation.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = [[[kawasan objectForKey:[sortedKawasan objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"solat.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:[[[kawasan objectForKey:[sortedKawasan objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] objectAtIndex:1] forKey:@"Code"];
    [data writeToFile:path atomically:YES];
    [data release];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headerView.png"]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 320, 20)];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    titleLabel.textColor = [UIColor blackColor];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

@end
