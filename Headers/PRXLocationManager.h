//
//  PRXLocationManager.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 9/16/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@class PRXSmartSpace;

@protocol PRXLocationManagerDelegate;

#pragma  mark - Notifications

// These notifications are sent out after the equivalent delegate message is called
extern NSString *const PRXLocationManagerDidEnterSmartSpace; // userInfo contains Smart Space object which was entered
extern NSString *const PRXLocationManagerDidExitSmartSpace; // userInfo contains Smart Space object which was exited
extern NSString *const PRXLocationManagerDidStartMonitoringForSmartSpace; // userInfo contains Smart Space object that is being monitored
extern NSString *const PRXLocationManagerDidStopMonitoringForSmartSpace; // userInfo contains Smart Space object that is being monitored
extern NSString *const PRXLocationManagerDidUpdateProximityServicesAvailibility;

// The keys used in the notification UserInfo
extern NSString *const PRXLocationManagerNotificationSmartSpaceItem;// They key for obtaining the Smart Space from the notification userInfo

/**
 *  PRXLocationManager
 *
 *  Discussion:
 *    The PRXLocationManager object is your entry point to location services.
 */
@interface PRXLocationManager : NSObject

#pragma  mark - Location Services

///-------------------------------------------------
/// @name LocationServices
///-------------------------------------------------

/*! Returns the application’s authorization status for using location services.
 *
 *  @return A value indicating whether the application is authorized to use location services.
 */
+(CLAuthorizationStatus)authorizationStatus;

/*! Returns a Boolean indicating whether the device supports beacon region monitoring.
 *
 *  The availability of beacon region monitoring support is dependent on the hardware present on the device and whether the user has location services enabled.
 *
 *  @return YES if the device supports beacon region monitoring or NO if it does not.
 */
+(BOOL)isSmartSpaceMonitoringAvailable;

/*! Returns a Boolean indicating whether the device supports ranging of Bluetooth beacons.
 *
 *  @return YES if the device supports ranging or NO if it does not.
 */
+(BOOL)isBeaconRangingAvailable;

/*! Returns a Boolean value indicating whether location services are enabled on the device.
 *
 *  The user can enable or disable location services from the Settings application by toggling the Location Services switch in General.
 *
 *  @return YES if proximity services are enabled or NO if they are not.
 */
+(BOOL)locationServicesEnabled;

/*! Returns a Boolean value indicating whether proximity services are enabled on the device.
 *
 *  @return YES if proximity services are enabled or NO if they are not.
 */
+(BOOL)proximityServicesEnabled;

#pragma  mark - Shared Manager

///-------------------------------------------------
/// @name SharedManager
///-------------------------------------------------

/*!
 *  Shared Manager
 *
 *  @return The Shared Location Manager
 */
+(PRXLocationManager*)sharedManager;

/*!
 *  Set the shared Manager
 *
 *  @param manager A LocationManager to set as the shared manager
 */
+(void)setSharedManager:(PRXLocationManager*)manager;

#pragma  mark - Properties

/*!
 *  The PRXLocationManager's delegate object
 */
@property (nonatomic,weak) id<PRXLocationManagerDelegate>delegate;

/*!
 *  Retrieve a set of objects for the smart spaces that are currently being monitored.  If any location manager
 *  has been instructed to monitor a smart space, during this or previous launches of your application, it will
 *  be present in this set.
 */
@property (nonatomic,copy,readonly) NSSet *monitoredSmartSpaces;

/*!
 *  Retrieve a set of objects representing the smart spaces for which this location manager is actively providing ranging.
 */
@property (nonatomic,copy,readonly) NSSet *rangedSmartSpaces;

/*!
 *  Boolean that indicates whether monitoring is enabled
 */
@property (nonatomic,assign,readonly) BOOL isMonitoring;

/*!
 *  Boolean that indicates whether ranging is enabled
 */
@property (nonatomic,assign,readonly) BOOL isRanging;

/*! Initializes and returns an PRXLocationManager object with the specified object as it's delegate
 *
 * @param delegate  A delegate object that wil respond to location manager updates 
 *
 *  @return A new PRXLocationManager object
 */
-(instancetype)initWithDelegate:(id<PRXLocationManagerDelegate>)delegate;

#pragma  mark - Smart Space Monitoring

///-------------------------------------------------
/// @name SmartspaceMonitoring
///-------------------------------------------------

/*! Starts monitoring the specified Smart Space.
 *
 *  You must call this method once for each Smart Space you want to monitor. If an existing Smart Space with the same identifier is already
 *  being monitored by the application, the old Smart Space is replaced by the new one.
 *
 * @param space The Smart Space object that defines the boundary to monitor. This parameter must not be nil.
 */
-(void)startMonitoringForSmartSpace:(PRXSmartSpace*)space;

/*! Stop monitoring the specified Smart Space.
 *
 *  If the specified smart space object is not currently being monitored, this method has no effect.
 * @Discussion this
 *
 * @param space The Smart Space object currently being monitored. This parameter must not be nil.
 */
-(void)stopMonitoringForSmartSpace:(PRXSmartSpace*)space;

/*! Stop Monitoring all Smart Spaces curently being monitored by the location manager.
 */
-(void)stopMonitoringAllSmartSpaces;

/*! Retrieves the state of a Smart Space asynchronously.
 *
 * @param space The Smart Space whose state you want to know.
 */
-(void)requestStateForSmartSpace:(PRXSmartSpace*)space;

/*! Check if the specified Smart Space is currently being monitored
 *
 * @param space The Smart Space to check if being monitored
 *
 * @return BOOL returns Yes if the Smart Space is currently being monitored No if it is not.
 */
-(BOOL)isMonitoringSmartSpace:(PRXSmartSpace*)space;

#pragma  mark - Smart Space Ranging

///-------------------------------------------------
/// @name SmartspaceRanging
///-------------------------------------------------

/*! Starts the delivery of notifications for beacons in the specified Smart Space.
 *
 * @param space The Smart Space object that defines the identifying information for the targeted beacons. The number of beacons represented by this Smart Space object depends on which identifier values you use to initialize it. Beacons must match all of the identifiers you specify.
 */
-(void)startRangingBeaconsInSmartSpace:(PRXSmartSpace*)space;

/*! Stops the delivery of notifications for the specified Smart Space.
 * 
 * @param space The Smart Space that identifies the beacons. 
 */
-(void)stopRangingBeaconsInSmartSpace:(PRXSmartSpace*)space;

/*! Stops the delivery of notifications for all Smart Spaces currently being ranged by the location manager.
 */
-(void)stopRangingBeaconsInAllSmartSpaces;

/*!
 Returns a boolean if the specified Smart Space is currently being ranged
 
 @param space The Smart Space to check if being ranged
 
 @return Returns Yes if the Smart Space is being ranged. No if it is not.
 */
-(BOOL)isRangingSmartSpace:(PRXSmartSpace*)space;

@end
