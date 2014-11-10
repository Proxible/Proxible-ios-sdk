
//
//  PRXBeaconFilter.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 10/18/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

@import Foundation;
@import CoreLocation;

//TODO: Write unit tests
//TODO: Add sorting as a paramter

/**
 *  PRXBeaconFilter
 *
 *  Discussion:
 *    The PRXBeaconFilter class provided methods to filter for specific beacons.
 */
@interface PRXBeaconFilter : NSObject

/*! Returns a Array with beacons sorted on closest.
 *
 *  @param beacons      An array of beacons to sort
 *
 *  @return Array of beacons sorted on closest
 */
+(NSArray*)sortOnClosestBeacons:(NSArray*)beacons;

/*! Returns a Array with beacons filtered on the given proximity.
 *
 *  @param beacons      An array of beacons to filter
 *  @param proximity    The proximity a beacon has to be in
 *  @param closest      A boolean indicating if only the closest beacon should be returend. If NO all beacons mathing the filter criteria are returned. If YES of all the beacons mathing the filter criteria only the closest of them all is returned. The beacons accucary is used to determine the closest beacon.
 *
 *  @return Array of beacons that match the filter criteria. 
 */
+(NSArray*)filterBeacons:(NSArray*)beacons withProximity:(CLProximity)proximity getClosest:(BOOL)closest;

/*! Returns a Array with beacons filtered on the given proximity and accuracy.
 *
 *  @param beacons      An array of beacons to filter
 *  @param proximity    The proximity a beacon has to be in
 *  @param accuracy     The accuracy of the beacon proximity from the mobile device
 *  @param closest      A boolean indicating if only the closest beacon should be returend. If NO all beacons mathing the filter criteria are returned. If YES of all the beacons mathing the filter criteria only the closest of them all is returned. The beacons accucary is used to determine the closest beacon.
 *
 *  @return Array of beacons that match the filter criteria.
 */
+(NSArray*)filterBeacons:(NSArray*)beacons withProximity:(CLProximity)proximity accuracy:(CLLocationAccuracy)accuracy getClosest:(BOOL)closest;

/*! Returns a Array with beacons filtered on the given list of proximities
 *
 *  @param beacons      An array of beacons to filter
 *  @param proximities  The list of proximities a beacon has to be in
 *  @param closest      A boolean indicating if only the closest beacon should be returend. If NO all beacons mathing the filter criteria are returned. If YES of all the beacons mathing the filter criteria only the closest of them all is returned. The beacons accucary is used to determine the closest beacon.
 *
 *  @return Array of beacons that match the filter criteria.
 */
+(NSArray*)filterBeacons:(NSArray*)beacons withProximities:(NSArray*)proximities getClosest:(BOOL)closest;


/*! Returns a Array with beacons filtered on the given list of proximities and accuracy
 *
 *  @param beacons      An array of beacons to filter
 *  @param proximities  The list of proximities a beacon has to be in
 *  @param accuracy     The accuracy of the beacon proximity from the mobile device
 *  @param closest      A boolean indicating if only the closest beacon should be returend. If NO all beacons mathing the filter criteria are returned. If YES of all the beacons mathing the filter criteria only the closest of them all is returned. The beacons accucary is used to determine the closest beacon.
 *
 *  @return Array of beacons that match the filter criteria.
 */
+(NSArray*)filterBeacons:(NSArray*)beacons withProximities:(NSArray*)proximities accuracy:(CLLocationAccuracy)accuracy getClosest:(BOOL)closest;

@end
