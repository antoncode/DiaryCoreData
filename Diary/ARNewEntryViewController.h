//
//  ARNewEntryViewController.h
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
// Don't import model header files into view controller header files.  Instead use @class declaration.
@class ARDiaryEntry;

@interface ARNewEntryViewController : UIViewController

@property (nonatomic, strong) ARDiaryEntry *entry;

@end
