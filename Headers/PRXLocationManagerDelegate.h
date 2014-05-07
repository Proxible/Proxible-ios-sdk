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
 * Delegate of the PRXLocationManager
 * The delegate gets informed about several actions in the SavingsGoalViewController, e.g. tapping on the bar
 *
 */
@protocol PRXLocationManagerDelegate <NSObject>

@optional



/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didDetermineState:(PRXSmartSpaceState)state forSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didEnterSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didExitSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager monitoringDidFailForSmartSpace:(PRXSmartSpace *)space withError:(NSError*)error;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didStartMonitoringForSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didStopMonitoringForSmartSpace:(PRXSmartSpace*)space;

#pragma mark - Responding to Ranging Events

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager didRangeBeacons:(NSArray*)beacons inSmartSpace:(PRXSmartSpace*)space;

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
- (void)locationManager:(PRXLocationManager*)manager rangingBeaconsDidFailForSmartSpace:(PRXSmartSpace*)space withError:(NSError *)error;

#pragma mark - Responding to Proximity Services Availibility

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
-(void)locationManager:(PRXLocationManager*)manager didUpdateProximityServicesAvailibility:(BOOL)available;

#pragma mark - Responding to Errors

/**
 * delegate methods that will tell the delegate the selected index in the indecesView
 *
 * @param view The view that calls the delegate
 * @param button The button that was tapped by the user
 */
-(void)locationManager:(PRXLocationManager*)manager didFailWithError:(NSError*)error;

@end
