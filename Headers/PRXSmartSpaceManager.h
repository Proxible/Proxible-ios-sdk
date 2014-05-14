//
//  PRXSmartSpaceManager.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 2/15/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXMSmartSpace;

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

@end
