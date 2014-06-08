//
//  ARDiaryEntity.m
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARDiaryEntity.h"


@implementation ARDiaryEntity

@dynamic date;          // dynamic instead of synthesize because core data will add setters and getters to these properties at run-time.
@dynamic body;
@dynamic imageData;
@dynamic mood;
@dynamic location;

@end
