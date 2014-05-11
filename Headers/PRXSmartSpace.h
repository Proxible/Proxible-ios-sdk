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

/**
 *  PRXSmartSpaceStateENUM
 *
 *  Discussion:
 *      The list of currently available smartspace states
 */

/*! This is an enum class listing the different states of a smartspace*/
typedef NS_ENUM(NSInteger,PRXSmartSpaceState){
    /*! Smartspace state is Unknown */
    PRXSmartSpaceStateUnknown,
    /*! Mobile device inside smartspace */
    PRXSmartSpaceStateInside,
    /*! Mobile device outside smartspace */
    PRXSmartSpaceStateOutside
};

extern NSString * NSStringFromSmartSpaceState(PRXSmartSpaceState state);


/**
 *  PRXSmartSpace
 *
 *  Discussion:
 *      This class handles and manages a local copy of smartspace data
 */
@interface PRXSmartSpace : NSObject <NSCopying>

#pragma mark - Smart Space Properties

///-------------------------------------------------
/// @name SmartSpaceProperties
///-------------------------------------------------

/**
 The ID for the smartspace from the Proxible Cloud
 */
@property (nonatomic,copy,readonly)NSString *smartSpaceID;

/**
 The user friendly name for the smart space
 */
@property (nonatomic,copy,readonly)NSString *name;

/**
 The description of the smartspace
 */
@property (nonatomic,copy,readonly)NSString *smartSpaceDescription;

/**
 The physical location / address where the smartspace is located at
 */
@property (nonatomic,strong,readonly)PRXAddress *address;

/**
 The time when the smartspace was created
 */
@property (nonatomic,copy,readonly) NSDate *createdAt;

/**
 The time when the smartspace was updated/modified
 */
@property (nonatomic,copy,readonly) NSDate *modifiedAt;

#pragma mark - Smart Space State

///-------------------------------------------------
/// @name SmartSpaceState
///-------------------------------------------------
/**
 The monitored state of the mobile device in the smartspace
 */
@property (nonatomic,assign,readonly)PRXSmartSpaceState state;

/**
 The time when the mobile device currently entered the smartspace
 */
@property (nonatomic,copy,readonly)NSDate *enteredAt;

/**
 The time when the mobile device currently exited from the smartspace
 */
@property (nonatomic,copy,readonly)NSDate *exitedAt;

/**
 The time spent by the mobile device in the smartspace (between currently entered and currently exited)
 */
@property (nonatomic,assign,readonly)NSTimeInterval timeSpentInSmartSpace;

/**
 The total number of times the smartspace was visited by the mobile device
 */
@property (nonatomic,assign,readonly)NSInteger totalVisits;

/**
 The time when the smartspace was entered the last time
 */
@property (nonatomic,copy,readonly)NSDate *lastEnteredAt;

/**
 The time when the smartspace was exited the last time
 */
@property (nonatomic,copy,readonly)NSDate *lastExitedAt;

/**
 The time spent by the mobile device during the last entry / exit
 */
@property (nonatomic,assign,readonly)NSTimeInterval lastTimeSpentInSmartSpace;

@end
