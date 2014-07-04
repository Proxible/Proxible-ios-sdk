//
//  PRXContent.h
//  ProxibleSDK
//
//  Created by Conrad Bartels Daal on 4/3/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  PRXContent
 *
 *  Discussion:
 *    The PRXContent class represents the model of a local copy of content corresponding to a smartspace
 */
@interface PRXContent : NSObject

/**
 The ID for the smartspace that the content belongs to from the Proxible Cloud
 */
@property (nonatomic,copy,readonly)NSString *smartSpaceID;

/** 
 The list of text content belonging to the content
 */
@property (nonatomic,copy,readonly)NSDictionary *textContent;

/**
 The list of media content belonging to the content
 */
@property (nonatomic,copy,readonly)NSDictionary *mediaContent;

/**
 The time when the smartspace content was last modified
 */
@property (nonatomic,copy,readonly) NSString *contentLastModifiedAt;

/**
 The list of text content keys
 */
-(NSArray*)textContentKeys;

/**
 The list of text content values
 */
-(NSArray*)textContentValues;

/**
 The list of media content keys
 */
-(NSArray*)mediaContentKeys;

/**
 The list of media content values
 */
-(NSArray*)mediaContentItems;

@end
