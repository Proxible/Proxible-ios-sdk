//
//  PRXError.h
//  ProxibleBeaconSDK
//
//  Created by Conrad Bartels Daal on 9/28/13.
//  Copyright (c) 2013 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  @const ProxibleBeaconSDKDomain
 *   @discussion The NSError domain of all errors returned by the ProxibleBeacon SDK.
 */
extern NSString *const ProxibleMonotoringDomain;
extern NSString *const ProxibleWebAPIDomain;

/*!
 @abstract Error codes returned by the Proxible SDK in NSError.
 
 @discussion
 These are valid only in the scope of ProxibleSDKDomain.
 */
typedef enum PRXMonotoringErrorCode {
    
    kPRXErrorLocationUnknown  = 0,
    kPRXErrorDenied,
    kPRXErrorNetwork,
    kPRXErrorHeadingFailure,
    kPRXErrorRegionMonitoringDenied,
    kPRXErrorRegionMonitoringFailure,
    kPRXErrorRegionMonitoringSetupDelayed,
    kPRXErrorRegionMonitoringResponseDelayed,
    kPRXErrorGeocodeFoundNoResult,
    kPRXErrorGeocodeFoundPartialResult,
    kPRXErrorGeocodeCanceled,
    kPRXErrorDeferredFailed,
    kPRXErrorDeferredNotUpdatingLocation,
    kPRXErrorDeferredAccuracyTooLow,
    kPRXErrorDeferredDistanceFiltered,
    kPRXErrorDeferredCanceled,
    
}PRXErrorCode;

typedef enum PRXWebAPIErrorCode{
    kPRXAPIError500ISE,
    kPRXAPIError404NotFound,
    kPRXAPIError403Forbidden,
    kPRXAPIError401Unauthorized,
    kPRXAPIError400BadRequest,
}PRXWebAPIErrorCode;



