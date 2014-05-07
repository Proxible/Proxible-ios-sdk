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

//TODO: Finalize Class Comments
@interface PRXBeacon : NSObject <NSCopying>

#pragma  mark - Beacon Properties

/*! CallBack block for Smart Space monitoring */
@property (strong,readonly,nonatomic) NSUUID *proximityUUID;

/*! CallBack block for Smart Space monitoring */
@property (strong,readonly,nonatomic) NSNumber *major;

/*! CallBack block for Smart Space monitoring */
@property (strong,readonly,nonatomic) NSNumber *minor;

/*! CallBack block for Smart Space monitoring */
@property (assign,readonly,nonatomic) CLProximity proximity;

/*! CallBack block for Smart Space monitoring */
@property (assign,readonly,nonatomic) CLLocationAccuracy accuracy;

/*! CallBack block for Smart Space monitoring */
@property (assign,readonly,nonatomic) NSInteger rssi;

/*! CallBack block for Smart Space monitoring */
@property (strong,readonly,nonatomic) NSDate *firstDiscoveredAt;

/*! CallBack block for Smart Space monitoring */
@property (strong,readonly,nonatomic) NSDate *lastDiscoveredAt;

@property (strong,readonly,nonatomic) NSDate *lastRangedAt;

-(NSString*)proximityStringValue;

@end
