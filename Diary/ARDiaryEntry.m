//
//  ARDiaryEntity.m
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARDiaryEntry.h"


@implementation ARDiaryEntry

@dynamic date;          // dynamic instead of synthesize because core data will add setters and getters to these properties at run-time.
@dynamic body;
@dynamic imageData;
@dynamic mood;
@dynamic location;

- (NSString *)sectionName
{
    // Override getter
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

@end
