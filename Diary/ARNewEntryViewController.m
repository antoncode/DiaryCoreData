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

@interface ARNewEntryViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) enum ARDiaryEntryMood pickedMood;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) UIImage *pickedImage;

@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (strong, nonatomic) IBOutlet UIView *accessoryView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation ARNewEntryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *date;

    if (self.entry != nil) {
        self.textView.text = self.entry.body;
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
    self.textView.inputAccessoryView = self.accessoryView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertDiaryEntry
{
    ARCoreDataStack *coreDataStack = [ARCoreDataStack defaultStack];
    ARDiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ARDiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];      // Inserts new entity in to core data stack environment
    entry.body = self.textView.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    [coreDataStack saveContext];
}

- (void)updateDiaryEntry
{
    self.entry.body = self.textView.text;
    
    self.entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    ARCoreDataStack *coreDataStack = [ARCoreDataStack defaultStack];
    [coreDataStack saveContext];
}

- (void)promptForSource
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Camera Roll", nil];
    [actionSheet showInView:self.view];
}

# pragma mark - Action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForCamera];
        } else {
            [self promptForPhotoLibrary];
        }
    }
}

- (void)promptForCamera
{
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoLibrary
{
    UIImagePickerController *controller = [UIImagePickerController new];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
}
# pragma mark - Image picker controller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)setPickedImage:(UIImage *)pickedImage
{
    // Over ride pickedImage setter
    
    _pickedImage = pickedImage;
    
    if (pickedImage == nil) {
        [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
    } else {
        [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
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

- (IBAction)imageButtonWasPressed:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else  {
        [self promptForPhotoLibrary];
    }
}

@end


















