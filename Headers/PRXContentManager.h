//
//  PRXSmartSpaceContentDataController.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 4/16/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRXSmartSpace,PRXContent;

@interface PRXContentManager : NSObject

+(PRXContentManager*)sharedContentManager;

@property (nonatomic,strong)dispatch_queue_t completionQueue;

-(NSArray*)allContent;

-(PRXContent*)contentForSmartSpace:(PRXSmartSpace*)space;

-(void)getContentForSmartSpace:(PRXSmartSpace*)space completion:(void(^)(PRXContent*content,NSError *error))completion;

@end
