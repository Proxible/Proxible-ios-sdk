//
//  PRXBeacon.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 10/29/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@class PRXBeacon,PRXSmartSpace;

/**
 *  PRXBeacon
 *
 *  Discussion:
 *      This class handles and manages a local copy of a beacon data
 */
@interface PRXBeacon : NSObject <NSCopying>

#pragma  mark - Beacon Properties

///-------------------------------------------------
/// @name BeaconProperties
///-------------------------------------------------

/**
 *  The smart space the beacons is belongs to.
 */
@property (strong,readonly,nonatomic)PRXSmartSpace *smartSpace;

/**
 The 16 byte UUID of the beacon region
 */
@property (strong,readonly,nonatomic) NSUUID *proximityUUID;

/**
 The 2 byte Major value of the beacon region
 */
@property (strong,readonly,nonatomic) NSNumber *major;

/**
 The 2 byte Minor value of the beacon region
 */
@property (strong,readonly,nonatomic) NSNumber *minor;

/**
 The proxmity of the beacon from the mobile device, namely: Immediate, Nearby, Far, Unknown
 */
@property (assign,readonly,nonatomic) CLProximity proximity;

/**
 The accuracy data calculated by the corelocation of the beacon, usually represents the approximate distance between the mobile device and beacon in terms of [m]
 */
@property (assign,readonly,nonatomic) CLLocationAccuracy accuracy;

/**
 The RSSI value of the signal received by the mobile device from the beacon
 */
@property (assign,readonly,nonatomic) NSInteger rssi;

/**
 The time when the beacon was first discovered by the device
 */
@property (strong,readonly,nonatomic) NSDate *firstDiscoveredAt;

/**
 The time when the last advertisement packet was received from the beacon
 */
@property (strong,readonly,nonatomic) NSDate *lastDiscoveredAt;

/**
 The time when the beacon region/smartspace was last ranged
 */
@property (strong,readonly,nonatomic) NSDate *lastRangedAt;

/*! The string value corresponding to the corelocation proximity of the beacon, namely: "Immediate", "Near", "Far", "Unknown"
 *
 * @return  The string value corresponding to the corelocation proximity of the beacon
 */
-(NSString*)proximityStringValue;

@end
