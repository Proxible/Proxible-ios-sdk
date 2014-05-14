//
//  PDBeaconCell.h
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 1/23/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDBeaconCell : UITableViewCell

-(void)configureCellWithBeacon:(PRXBeacon*)beacon;

@end
