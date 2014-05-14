//
//  SDKAppDelegate.h
//  SDKDemo
//
//  Created by Conrad Bartels Daal on 5/14/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
