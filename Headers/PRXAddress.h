//
//  PRXAddress.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 1/16/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

/**
 *  PRXAddress
 *
 *  Discussion:
 *    The PRXAddress stores and manages a local copy of the address details of a given smartspace
 */
@interface PRXAddress : NSObject <NSCopying>

/**
 The ID assigned to the address in the Proxible Cloud
 */
@property (nonatomic, copy,readonly) NSString *addressID;

/**
 The street information of the address
 */
@property (nonatomic, copy,readonly) NSString *streetLine1;

/**
 The extra information about the street of the address
 */
@property (nonatomic, copy,readonly) NSString *streetLine2;

/**
 The name of the city where the address belongs to
 */
@property (nonatomic, copy,readonly) NSString *cityName;

/**
 The short representation of the state or region where the address is located in
 */
@property (nonatomic, copy,readonly) NSString *stateAbbrev;

/**
 The postal code or zip code corresponding to the address
 */
@property (nonatomic, copy,readonly) NSString *zipCode;

/**
 The name of the country where the address belongs to
 */
@property (nonatomic, copy,readonly) NSString *countryName;

/**
 The latitude of the gps coordinates of the address
 */
@property (nonatomic, copy,readonly) NSNumber *latitude;

/**
 The longitude of the gps coordinates of the address
 */
@property (nonatomic, copy,readonly) NSNumber *longitude;

/*! Creates a location object based on the latitude and longitude from the address
 *
 * @return location     The CLLocation object created with the latitude and longitude of the location
 */
- (CLLocation *)location;

/**
 *  The full string representation of the addresss with the components seperated by commas.
 *
 *  @return String representation of full address seperated by commas.
 */
-(NSString*)fullAddress;

@end
