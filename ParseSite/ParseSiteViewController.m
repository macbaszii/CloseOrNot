//
//  ParseSiteViewController.m
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/2/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ParseSiteViewController.h"
#import "ParseSiteAppDelegate.h"

#define kName @"name"
#define kOpen @"openTime"
#define kClose @"closeTime"
#define kAlter @"alterNames"

@implementation ParseSiteViewController
@synthesize places, filteredPlaces;
@synthesize tableView = _tableView;
@synthesize parser;

- (NSManagedObjectContext *)managedObjectContext{
    ParseSiteAppDelegate *appDelegate = (ParseSiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)fetchPlacesData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Places" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:kName ascending:NO];
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    
    self.places = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
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

#pragma mark ParsingDataDelegate 

- (void)paringDataDidFinished:(ParsingData *)controller{
    [self fetchPlacesData];
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
