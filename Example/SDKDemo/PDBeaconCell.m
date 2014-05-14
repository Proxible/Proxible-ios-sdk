//
//  PDBeaconCell.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 1/23/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDBeaconCell.h"

@interface PDBeaconCell()

@property (nonatomic,weak)IBOutlet UILabel *beaconUUIDLabel;
@property (nonatomic,weak)IBOutlet UILabel *beaconMajorLabel;
@property (nonatomic,weak)IBOutlet UILabel *beaconMinorLabel;
@property (nonatomic,weak)IBOutlet UILabel *beaconProximityLabel;
@property (nonatomic,weak)IBOutlet UILabel *beaconRSSILabel;
@property (nonatomic,weak)IBOutlet UILabel *beaconAccuracyLabel;

@end

@implementation PDBeaconCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithBeacon:(PRXBeacon*)beacon{
    
    self.beaconUUIDLabel.text = [beacon.proximityUUID UUIDString];
    self.beaconMajorLabel.text = [beacon.major stringValue];
    self.beaconMinorLabel.text = [beacon.minor stringValue];
    self.beaconProximityLabel.text = [beacon proximityStringValue];
    self.beaconRSSILabel.text = [NSString stringWithFormat:@"%i",beacon.rssi];
    self.beaconAccuracyLabel.text = [NSString stringWithFormat:@"%.02f",beacon.accuracy];
}

@end
