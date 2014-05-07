//
//  PRXSmartSpaceManager.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 2/15/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXMSmartSpace;

@interface PRXSmartSpaceManager : NSObject

+(PRXSmartSpaceManager*)sharedSmartSpaceManager;

@property (nonatomic,strong)dispatch_queue_t completionQueue;

-(NSArray*)allSmartSpaces;

-(void)getAllSmartSpacesWithCompletion:(void(^)(NSArray* smartSpaces, NSError *error))completion;

@end
