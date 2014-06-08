//
//  ARDiaryEntity.h
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ENUM (int16_t, ARDiaryEntryMood)
{
    ARDiaryEntryMoodGood = 0,
    ARDiaryEntryMoodAverage = 1,
    ARDiaryEntryMoodBad = 2
};

@interface ARDiaryEntity : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic) int16_t mood;
@property (nonatomic, retain) NSString * location;

@end
