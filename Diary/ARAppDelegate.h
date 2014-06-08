//
//  ARAppDelegate.h
//  Diary
//
//  Created by Anton Rivera on 6/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
