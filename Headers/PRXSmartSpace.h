//
//  PRXSmartSpace.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 10/29/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

//TODO: Finalize Class Comments

@import Foundation;

@class PRXAddress,PRXContent;

typedef NS_ENUM(NSInteger,PRXSmartSpaceState){
    PRXSmartSpaceStateUnknown,
    PRXSmartSpaceStateInside,
    PRXSmartSpaceStateOutside
};

extern NSString * NSStringFromSmartSpaceState(PRXSmartSpaceState state);

@interface PRXSmartSpace : NSObject <NSCopying>

#pragma mark - Smart Space Properties

@property (nonatomic,copy,readonly)NSString *smartSpaceID;

@property (nonatomic,copy,readonly)NSString *name;

@property (nonatomic,copy,readonly)NSString *smartSpaceDescription;

@property (nonatomic,strong,readonly)PRXAddress *address;

@property (nonatomic,copy,readonly) NSDate *createdAt;

@property (nonatomic,copy,readonly) NSDate *modifiedAt;

#pragma mark - Smart Space State

@property (nonatomic,assign,readonly)PRXSmartSpaceState state;

@property (nonatomic,copy,readonly)NSDate *enteredAt;

@property (nonatomic,copy,readonly)NSDate *exitedAt;

@property (nonatomic,assign,readonly)NSTimeInterval timeSpentInSmartSpace;

@property (nonatomic,assign,readonly)NSInteger totalVisits;

@property (nonatomic,copy,readonly)NSDate *lastEnteredAt;

@property (nonatomic,copy,readonly)NSDate *lastExitedAt;

@property (nonatomic,assign,readonly)NSTimeInterval lastTimeSpentInSmartSpace;

@end
