//
//  PRXLocationManagerDelegate.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 1/7/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

//TODO: Finalize Class Comments

#import <Foundation/Foundation.h>
#import "PRXSmartSpace.h"

/**
 * PRXLocationManagerDelegate
 *
 * Discussion:
 * This class acts as a delegate of the PRXLocationManager
 * The delegate gets informed about several actions of monitoring a smartspace
 *
 */
@protocol PRXLocationManagerDelegate <NSObject>

@optional



/**
 * delegate method when the state of a smartspace is determined
 *
 * @param manager   The manager that determines the state
 * @param state     The current determined state of the smartspace
 * @param space     The smartspace for which the state is determined
 */
- (void)locationManager:(PRXLocationManager*)manager didDetermineState:(PRXSmartSpaceState)state forSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate method when the mobile device enters a monitored smartspace
 *
 * @param manager   The manager that detects the entry
 * @param space     The smartspace that the mobile device enters
 */
- (void)locationManager:(PRXLocationManager*)manager didEnterSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate method when the mobile device exits a monitored smartspace
 *
 * @param manager   The manager that detects the exit
 * @param space     The smartspace that the mobile device exits
 */
- (void)locationManager:(PRXLocationManager*)manager didExitSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate method when the monitoring of smartspace fails
 *
 * @param manager   The manager for which the monitoring fails
 * @param space     The smartspace that fails to be monitored
 * @param error     The error generated while monitoring the smartspace
 */
- (void)locationManager:(PRXLocationManager*)manager monitoringDidFailForSmartSpace:(PRXSmartSpace *)space withError:(NSError*)error;

/**
 * delegate method when the monitoring of smartspace starts
 *
 * @param manager   The manager that starts the monitoring
 * @param space     The smartspace for which monitoring is started
 */
- (void)locationManager:(PRXLocationManager*)manager didStartMonitoringForSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate method when the monitoring of smartspace stops
 *
 * @param manager   The manager that stops the monitoring
 * @param space     The smartspace for which monitoring is stopped
 */
- (void)locationManager:(PRXLocationManager*)manager didStopMonitoringForSmartSpace:(PRXSmartSpace*)space;

#pragma mark - Responding to Ranging Events

/**
 * delegate method when beacons are ranged
 *
 * @param manager   The manager that ranges beacons
 * @param beacons   The list of beacons that are being ranged
 * @param space     The smartspace to which the beacons belongs to
 */
- (void)locationManager:(PRXLocationManager*)manager didRangeBeacons:(NSArray*)beacons inSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate method when beacons ranging fails
 *
 * @param manager   The manager that ranges beacons
 * @param space     The smartspace to which the beacons belongs to
 * @param error     The error that's generated while ranging
 */
- (void)locationManager:(PRXLocationManager*)manager rangingBeaconsDidFailForSmartSpace:(PRXSmartSpace*)space withError:(NSError *)error;

#pragma mark - Responding to Proximity Services Availibility

/**
 * delegate method when availability of proximity service is updated
 *
 * @param manager   The manager for which the availability status is updated
 * @param available Indicates if Proximity services are available or not
 */
-(void)locationManager:(PRXLocationManager*)manager didUpdateProximityServicesAvailibility:(BOOL)available;

#pragma mark - Responding to Errors

/**
 * delegate method when Location manager service fails
 *
 * @param manager   The manager for which the service fails
 * @param error     The error that's generated
 */
-(void)locationManager:(PRXLocationManager*)manager didFailWithError:(NSError*)error;

@end
