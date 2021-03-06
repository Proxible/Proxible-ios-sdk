//
//  ProxibleSDK.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 1/6/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRXSmartSpace.h"
#import "PRXAddress.h"
#import "PRXContent.h"
#import "PRXBeacon.h"
#import "PRXLocationManager.h"
#import "PRXLocationManagerDelegate.h"
#import "PRXSmartSpaceManager.h"
#import "PRXContentManager.h"
#import "PRXBeaconFilter.h"
#import "PRXError.h"


//Default to staging
typedef NS_ENUM(NSInteger, PRXEnvironment){
    Development,
    Staging,
    Producton
};

extern NSString * const PRXTrackingOptionEnabled;
extern NSString *const kPRXGlobalSmartSpaceName;
extern NSString *const kPRXGlobalSmartSpaceID;

/**
 *  ProxibleSDK
 *
 *  Discussion:
 *    The ProxibleSDK class acts the main handler and interface for the various features of this SDK.
 */
@interface ProxibleSDK : NSObject

/*! Initializes the SDK with the given company ID, application ID and apikey
 *
 * @param appID     The ID of the app accessing the SDK
 * @param apiKey    The APIKey required to access the cloud via the SDK
 */
+(void)setApplicationID:(NSString*)appID apiKey:(NSString*)apiKey;

/*! Set various options for the SDK, currently the only option available is to enable/disable tracking
 *
 * @param options   The dictionary containing various options for the SDK
 */
+(void)setOptions:(NSDictionary*)options;

/*! Returns if tracking is enabled or not
 *
 * @return YES- if tracking is enabled, otherwise NO
 */
+(BOOL)trackingEnabled;

/*! Returns the ID of the application associated with the SDK
 *
 * @return The ID of the application associated with the SDK
 */
+(NSString*)applicationID;

/*! Returns the apiKey that is required to access the cloud via the SDK
 *
 * @return The apiKey that is required to access the cloud via the SDK
 */
+(NSString*)apiKey;

/**
 *  The current enviroment used for the SDK
 *
 *  @return Enviroment enum
 */
+(PRXEnvironment)environment;

/**
 *  Set the enum to the desired cloud enviroment
 *
 *  @param environment The environment to set the SDK to point to
 */
+(void)setEnvironment:(PRXEnvironment)environment;

@end
