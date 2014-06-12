//
//  AREntryCell.h
//  Diary
//
//  Created by Anton Rivera on 6/11/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARDiaryEntry;

@interface AREntryCell : UITableViewCell

// Cell should be responsible for laying itself out, not the table view controller
+ (CGFloat)heightForEntry:(ARDiaryEntry *)entry;

- (void)configureCellForEntry:(ARDiaryEntry *)entry;

@end
