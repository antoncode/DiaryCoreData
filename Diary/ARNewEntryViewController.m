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
@property (nonatomic, assign) enum ARDiaryEntryMood pickedMood;

@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (strong, nonatomic) IBOutlet UIView *accessoryView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ARNewEntryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *date;

    if (self.entry != nil) {
        self.textField.text = self.entry.body;
        self.pickedMood = self.entry.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entry.date];
    } else {
        self.pickedMood = ARDiaryEntryMoodGood;
        date = [NSDate date];
    }
    
    NSDateFormatter *dateFormatter = [ NSDateFormatter new];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    // dynamically adds view with mood buttons on top of keyboard
    self.textField.inputAccessoryView = self.accessoryView;
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

- (void)setPickedMood:(enum ARDiaryEntryMood)pickedMood
{
    // over ride setter for pickedMood
    _pickedMood = pickedMood;
    
    self.badButton.alpha = 0.5f;
    self.goodButton.alpha = 0.5f;
    self.averageButton.alpha = 0.5f;
    
    switch (pickedMood) {
        case ARDiaryEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;
        case ARDiaryEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            break;
        case ARDiaryEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;
    }
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

- (IBAction)badWasPressed:(id)sender
{
    self.pickedMood = ARDiaryEntryMoodBad;
}

- (IBAction)averageWasPressed:(id)sender
{
    self.pickedMood = ARDiaryEntryMoodAverage;
}

- (IBAction)goodWasPressed:(id)sender
{
    self.pickedMood = ARDiaryEntryMoodGood;
}


@end


















