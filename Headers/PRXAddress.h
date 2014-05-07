//
//  PRXAddress.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 1/16/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface PRXAddress : NSObject <NSCopying>

@property (nonatomic, copy,readonly) NSString *addressID;
@property (nonatomic, copy,readonly) NSString *streetLine1;
@property (nonatomic, copy,readonly) NSString *streetLine2;
@property (nonatomic, copy,readonly) NSString *cityName;
@property (nonatomic, copy,readonly) NSString *stateAbbrev;
@property (nonatomic, copy,readonly) NSString *zipCode;
@property (nonatomic, copy,readonly) NSString *countryName;
@property (nonatomic, copy,readonly) NSNumber *latitude;
@property (nonatomic, copy,readonly) NSNumber *longitude;

- (CLLocation *)location;

@end
