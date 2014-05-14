//
//  PDSmartSpaceDescriptionTableViewCell.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpaceDescriptionTableViewCell.h"


@interface PDSmartSpaceDescriptionTableViewCell ()

@property (nonatomic,weak)IBOutlet UILabel *smartSpaceIDLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceNameLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceDescriptionLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceModifiedAtLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceCreatedAtLabel;
@property (nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation PDSmartSpaceDescriptionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)awakeFromNib
//{
//    // Initialization code
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

-(void)configureCellWithSmartSpace:(PRXSmartSpace*)space{
    
    self.smartSpaceIDLabel.text = space.smartSpaceID;
    self.smartSpaceNameLabel.text = space.name;
    self.smartSpaceDescriptionLabel.text = space.smartSpaceDescription;
    self.smartSpaceCreatedAtLabel.text = [self.dateFormatter stringFromDate:space.createdAt];
    if (space.modifiedAt == nil) {
        self.smartSpaceModifiedAtLabel.text = @"Not motified";
    }else{
        self.smartSpaceModifiedAtLabel.text = [self.dateFormatter stringFromDate:space.modifiedAt];
    }
}

-(NSDateFormatter*)dateFormatter{
    static NSDateFormatter *__dateFormatter = nil;
    if (__dateFormatter == nil) {
        __dateFormatter = [[NSDateFormatter alloc]init];
        [__dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [__dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }return __dateFormatter;
}

@end
