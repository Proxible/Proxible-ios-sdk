//
//  PRXContent.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 4/3/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRXContent : NSObject

@property (nonatomic,copy,readonly)NSDictionary *textContent;

@property (nonatomic,copy,readonly)NSDictionary *mediaContent;

-(NSArray*)textContentKeys;

-(NSArray*)textContentValues;

-(NSArray*)mediaContentKeys;

-(NSArray*)mediaContentItems;

@end
