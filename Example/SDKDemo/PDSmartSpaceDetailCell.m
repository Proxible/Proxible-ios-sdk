//
//  PDSmartSpaceCell.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 2/5/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpaceDetailCell.h"

static void * XXContext = &XXContext;

@interface PDSmartSpaceDetailCell(){
    PRXSmartSpace *_space;
}

@property (nonatomic,weak)IBOutlet UILabel *smartSpaceIDLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceNameLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceStateLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceTotalVisitsLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceEnteredLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceExitedLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceTimeSpentLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceLastEnteredLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceLastExitedLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceLastTimeSpentLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceModifiedAtLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceCreatedAtLabel;

@property (nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation PDSmartSpaceDetailCell

-(NSDateFormatter*)dateFormatter{
    static NSDateFormatter *__dateFormatter = nil;
    if (__dateFormatter == nil) {
        __dateFormatter = [[NSDateFormatter alloc]init];
        [__dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [__dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }return __dateFormatter;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    [self removeObservation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithSmartSpace:(PRXSmartSpace*)space{
    [self removeObservation];
    _space = space;
    [self updateUIWithSmartSpace:_space];
    [self addObservation];
}

-(void)updateUIWithSmartSpace:(PRXSmartSpace*)space{
    self.smartSpaceIDLabel.text = space.smartSpaceID;
    self.smartSpaceNameLabel.text = space.name;
    self.smartSpaceStateLabel.text = NSStringFromSmartSpaceState(space.state);
    self.smartSpaceTotalVisitsLabel.text = [@(space.totalVisits) stringValue];
    
    self.smartSpaceCreatedAtLabel.text = [self.dateFormatter stringFromDate:space.createdAt];
    
    if (space.lastEnteredAt == nil) {
        self.smartSpaceLastEnteredLabel.text = @"Not entered";
    }else{
        self.smartSpaceLastEnteredLabel.text = [self.dateFormatter stringFromDate:space.lastEnteredAt];
    }
    
    if (space.lastExitedAt == nil) {
        self.smartSpaceLastExitedLabel.text = @"Not exited";
    }else{
        self.smartSpaceLastExitedLabel.text = [self.dateFormatter stringFromDate:space.lastExitedAt];
    }
    
    if (space.lastTimeSpentInSmartSpace == 0) {
        self.smartSpaceLastTimeSpentLabel.text =@"No time";
    }else{
        self.smartSpaceLastTimeSpentLabel.text = [NSString stringWithFormat:@"%2.0f",space.lastTimeSpentInSmartSpace];
    }
    
    if (space.enteredAt == nil) {
        self.smartSpaceEnteredLabel.text = @"Not entered";
    }else{
        self.smartSpaceEnteredLabel.text = [self.dateFormatter stringFromDate:space.enteredAt];
    }
    
    if (space.exitedAt == nil) {
        self.smartSpaceExitedLabel.text = @"Not exited";
    }else{
        self.smartSpaceExitedLabel.text = [self.dateFormatter stringFromDate:space.exitedAt];
    }
    
    if (space.timeSpentInSmartSpace == 0) {
        self.smartSpaceTimeSpentLabel.text =@"No time";
    }else{
        self.smartSpaceTimeSpentLabel.text = [NSString stringWithFormat:@"%2.0f",space.timeSpentInSmartSpace];
    }
    
    if (space.modifiedAt == nil) {
        self.smartSpaceModifiedAtLabel.text = @"Not motified";
    }else{
        self.smartSpaceModifiedAtLabel.text = [self.dateFormatter stringFromDate:space.modifiedAt];
    }
}

-(void)addObservation{
    [_space addObserver:self forKeyPath:NSStringFromSelector(@selector(totalVisits)) options:NSKeyValueObservingOptionNew context:XXContext];
    [_space addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionNew context:XXContext];
}

-(void)removeObservation{
    [_space removeObserver:self forKeyPath:NSStringFromSelector(@selector(totalVisits)) context:XXContext];
    [_space removeObserver:self forKeyPath:NSStringFromSelector(@selector(state)) context:XXContext];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (context == XXContext) {
        
        [self updateUIWithSmartSpace:_space];
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
