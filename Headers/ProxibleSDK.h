//
//  ProxibleSDK.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 1/6/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ProxibleSDK/PRXSmartSpace.h>
#import <ProxibleSDK/PRXContent.h>
#import <ProxibleSDK/PRXBeacon.h>
#import <ProxibleSDK/PRXLocationManager.h>
#import <ProxibleSDK/PRXLocationManagerDelegate.h>
#import <ProxibleSDK/PRXSmartSpaceManager.h>
#import <ProxibleSDK/PRXContentManager.h>
#import <ProxibleSDK/PRXBeaconFilter.h>

extern NSString * const PRXTrackingOptionEnabled;

//TODO: Set up global configuration methods. Like for setting application key and API key
@interface ProxibleSDK : NSObject

+(void)setCompanyID:(NSString*)companyID applicationID:(NSString*)appID apiKey:(NSString*)apiKey;

+(void)setOptions:(NSDictionary*)options;

+(BOOL)trackingEnabled;
+(NSString*)applicationID;
+(NSString*)apiKey;
+(NSString*)companyID;
@end
