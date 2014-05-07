
//
//  PRXBeaconFilter.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 10/18/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

@import Foundation;
@import CoreLocation;

//TODO: Finalize Class Comments
//TODO: Write unit tests
//TODO: Add sorting as a paramter

/*
 *  PRXBeaconFilter
 *
 *  Discussion:
 *    The PRXBeaconFilter class provided methods to filter for specific beacons.
 */
@interface PRXBeaconFilter : NSObject

/*! Returns a Array with beacons filtered on the given proximity.
 *
 *  @parm beacons An array of beacons to filter 
 *  @parm proximity The proximity a beacon has to be in
 *  @parm closest A boolean indicating if only the closest beacon should be returend. If NO all beacons mathing the filter criteria are returned. If YES of all the beacons mathing the filter criteria only the closest of them all is returned. The beacons accucary is used to determine the closest beacon. 
 *
 *  @return Array of beacons that match the filter criteria. 
 */
+(NSArray*)filterBeacons:(NSArray*)beacons withProximity:(CLProximity)proximity getClosest:(BOOL)closest;


+(NSArray*)filterBeacons:(NSArray*)beacons withProximity:(CLProximity)proximity accuracy:(CLLocationAccuracy)accuracy getClosest:(BOOL)closest;

+(NSArray*)filterBeacons:(NSArray*)beacons withProximities:(NSArray*)proximities getClosest:(BOOL)closest;


+(NSArray*)filterBeacons:(NSArray*)beacons withProximities:(NSArray*)proximities accuracy:(CLLocationAccuracy)accuracy getClosest:(BOOL)closest;

@end
