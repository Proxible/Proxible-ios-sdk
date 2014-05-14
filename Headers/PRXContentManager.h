//
//  PRXSmartSpaceContentDataController.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 4/16/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXSmartSpace,PRXContent;

/**
 *  PRXContentManager
 *
 *  Discussion:
 *    The PRXContentManager class acts as a handler for all content related data and operations.
 */
@interface PRXContentManager : NSObject

/*! Returns a singleton object of PRXContentManager
 *
 * @return shared singleton object of PRXContentManager
 */
+(PRXContentManager*)sharedContentManager;

/**
 The dispatch queue for `completionBlock`. If `NIL` (default), the main queue is used.
 */
@property (nonatomic,strong)dispatch_queue_t completionQueue;

/*! Fetches immutable copies of all the contents stored locally on the disk
 *
 * @return a list of all available contents in the disk
 */
-(NSArray*)allContent;

/*! Retrieves the content for a given smartspaces from the disk
 *
 * @param space     The smartspace for which the content needs to be retrieved
 */
-(PRXContent*)contentForSmartSpace:(PRXSmartSpace*)space;


/*! Downloads and updates the contents for a given smartspaces from the cloud
 *
 * @param space         The smartspace for which the content needs to be downloaded
 * @param completion    The completion block to be executed after the downloading is done
 */
-(void)getContentForSmartSpace:(PRXSmartSpace*)space completion:(void(^)(PRXContent*content,NSError *error))completion;

@end