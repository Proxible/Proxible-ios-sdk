//
//  PRXSmartSpaceManager.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 2/15/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXSmartSpace,PRXBeacon;

/**
 *  PRXSmartSpaceManager
 *
 *  Discussion:
 *    The PRXSmartSpaceManager class acts as a handler for all Smartspace related data and operations.
 */
@interface PRXSmartSpaceManager : NSObject

/*! Returns a singleton object of PRXSmartSpaceManager
 *
 * @return shared singleton object of PRXSmartSpaceManager
 */
+(PRXSmartSpaceManager*)sharedInstance;

/**
 The dispatch queue for `completionBlock`. If `NIL` (default), the main queue is used.
 */
@property (nonatomic,strong)dispatch_queue_t completionQueue;

/**
 *  The global smart space represents a smart space that is equal to all smart spaces in the application. It has a default smart space ID and Name. Use the global smart space to monitor or range for any smart space in the application. 
 *
 *  @return PRXSmartSpace with global smart space ID and Name. Nil if no smat spaces have been downloaded yet.
 */
-(PRXSmartSpace*)globalSmartSpace;

/**
 *  Fetches an immutable copy of the smart space with the specified smart space id stored locally on the disk.
 *
 *  @param smartSpaceID The smart space id
 *
 *  @return PRXSmartSpace with given id
 */
-(PRXSmartSpace*)smartSpaceWithID:(NSString*)smartSpaceID;

/**
 *  Fetches immutable copies of the smart spaces with the specified smart space ids stored locally on the disk.
 *
 *  @param smartSpaceIDs Array of smart space ids
 *
 *  @return Array of PRXSmartSpaces with matching id
 */
-(NSArray*)smartSpacesWithIDs:(NSArray*)smartSpaceIDs;

/**
 *  Fetches an immutable copy of the smart space with the specified PRXBeacon stored locally on the disk.
 *
 *  @param beacon The PRXBeacon that belongs to the smart space
 *
 *  @return PRXSmartSpace with the specified PRXBeacon.
 */
-(PRXSmartSpace*)smartSpaceWithBeacon:(PRXBeacon*)beacon;

/**
 *  Fetches an immutable copy of the smart space with the specified name stored locally on the disk.
 *
 *  @param name The name of the smart space
 *
 *  @return PRXSmartSpace with given name
 */
-(PRXSmartSpace*)smartSpaceWithName:(NSString*)name;

/*! Fetches immutable copies of all the smartspaces stored locally on the disk
 *
 * @return a list of all available smart spaces in the disk
 */
-(NSArray*)allSmartSpaces;

/*! Downloads and synchronizes all the the smartspaces from the cloud
 *
 * @param completion The completion block to be executed after the fetching is done
 */
-(void)getAllSmartSpacesWithCompletion:(void(^)(NSArray* smartSpaces, NSError *error))completion;

/*! Downloads and synchronizes all the the smartspaces with the option to include the smart space content from the cloud
 *
 * @param includeContent Boolean indicating to download and synchronize all content 
 * @param completion The completion block to be executed after the fetching is done
 */
-(void)getAllSmartSpacesShouldIncludeContent:(BOOL)includeContent completion:(void(^)(NSArray* smartSpaces, NSError *error))completion;

@end
