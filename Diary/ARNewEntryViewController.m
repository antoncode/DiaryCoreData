//
//  ARNewEntryViewController.m
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARNewEntryViewController.h"
#import "ARDiaryEntry.h"
#import "ARCoreDataStack.h"

@interface ARNewEntryViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ARNewEntryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.entry != nil) {
        self.textField.text = self.entry.body;
    }
}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertDiaryEntry
{
    ARCoreDataStack *coreDataStack = [ARCoreDataStack defaultStack];
    ARDiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ARDiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];      // Inserts new entity in to core data stack environment
    entry.body = self.textField.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [coreDataStack saveContext];
}

- (void)updateDiaryEntry
{
    self.entry.body = self.textField.text;
    
    ARCoreDataStack *coreDataStack = [ARCoreDataStack defaultStack];
    [coreDataStack saveContext];
}

- (IBAction)doneWasPressed:(id)sender
{
    if (self.entry != nil) {
        [self updateDiaryEntry];
    } else {
        [self insertDiaryEntry];
    }
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender
{
    [self dismissSelf];
}


@end
