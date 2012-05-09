//
//  ParseSiteViewController.m
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/2/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ParseSiteViewController.h"
#import "ParseSiteAppDelegate.h"
#import "DetailViewController.h"

#define kName @"name"
#define kOpen @"openTime"
#define kClose @"closeTime"
#define kAlter @"alterNames"

@implementation ParseSiteViewController
@synthesize places, filteredPlaces;
@synthesize tableView = _tableView;
@synthesize parser;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)parsingDataWithParser{
    self.parser = [[ParsingData alloc] init];
    self.parser.delegate = self;
    [self.parser setupParseService];
    [self.parser getFromWebService];
}

#pragma mark - UISearchDisplayDelegate

- (NSArray *)arrayForTableView:(UITableView *)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.filteredPlaces;
    }else{
        return self.places;
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@",kName,searchString];
    self.filteredPlaces = [self.places filteredArrayUsingPredicate:predicate];
    
    NSPredicate *predicateWithAlter = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@",kAlter,searchString];
    self.filteredPlaces = [self.places filteredArrayUsingPredicate:predicateWithAlter];
    
    return YES;
}

#pragma mark UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self arrayForTableView:tableView] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //ConfigureCell
    NSArray *selectedArray = [self arrayForTableView:tableView];
    Places *currentPlaces = [selectedArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentPlaces.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",currentPlaces.openTime,currentPlaces.closeTime];
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *destinationViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    Places *selectedData = [self.places objectAtIndex:indexPath.row];
    destinationViewController.placeDetail = selectedData;
    [self.navigationController pushViewController:destinationViewController animated:YES];
}

#pragma mark ParsingDataDelegate 

- (void)paringDataDidFinished:(ParsingData *)controller{
    self.places = [parser fetchPlacesData];
    [self.tableView reloadData];
}

#pragma mark - RefreshButton Touched

- (IBAction)refreshButton{
    [self.parser getFromWebService];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CloseOrNot";
    self.places = [[NSArray alloc] init];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButton)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [self parsingDataWithParser];
  	// Do any additional setup after loading the view, typically from a nib.
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
