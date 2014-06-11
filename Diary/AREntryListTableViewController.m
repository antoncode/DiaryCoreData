//
//  AREntryListTableViewController.m
//  Diary
//
//  Created by Anton Rivera on 6/10/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "AREntryListTableViewController.h"
#import "ARCoreDataStack.h"
#import "ARDiaryEntry.h"

@interface AREntryListTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AREntryListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.fetchedResultsController performFetch:nil];
}

- (NSFetchRequest *)entryListFetchRequest
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ARDiaryEntry"];
    
    // Array of sort descriptors with only one object
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    // Override fetchedresultscontroller getter using lazy loading
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    ARCoreDataStack *coreDataStack = [ARCoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:coreDataStack.managedObjectContext
                                                                      sectionNameKeyPath:@"sectionName"
                                                                               cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Grab sectionInfo from NSFetchedResultsController.  Return number of objects in sectionInfo.  Each section in the table view will comprise the different sections of fetchedResultsController.  Different objects with different section keypaths.  Objects with different section keypaths will be placed in different sections.
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ARDiaryEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = entry.body;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo name];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // Reload table view when content being displayed changes.
    [self.tableView reloadData];
}

@end











