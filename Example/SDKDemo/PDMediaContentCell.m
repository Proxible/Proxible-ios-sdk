//
//  PDMediaContentTableViewCell.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDMediaContentCell.h"

@interface PDMediaContentCell ()

@property (nonatomic,strong)IBOutlet UILabel *mediaKeyLabel;
@property (nonatomic,strong)IBOutlet UIImageView *mediaImageView;
@end

@implementation PDMediaContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.mediaImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMediaContentKey:(NSString*)key{
    self.mediaKeyLabel.text = key;
}

-(void)setMediaContentImage:(UIImage*)mediaImage{
    self.mediaImageView.image = mediaImage;
}

@end
