//
//  PRXSmartSpaceManager.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 2/15/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXSmartSpace;

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
+(PRXSmartSpaceManager*)sharedSmartSpaceManager;

/**
 The dispatch queue for `completionBlock`. If `NIL` (default), the main queue is used.
 */
@property (nonatomic,strong)dispatch_queue_t completionQueue;


/*! Fetches an immutable copy of the smart space with the specified smart space id stored locally on the disk.
 *
 * @param smartSpaceID The smart space id 
 */
-(PRXSmartSpace*)smartSpaceWithID:(NSString*)smartSpaceID;

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
