//
//  PDSmartSpaceDetailTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/12/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpaceDetailTableViewController.h"
#import "PDSmartSpaceContentTableViewController.h"
#import "PDMapViewController.h"

@interface PDSmartSpaceDetailTableViewController ()

@property (nonatomic,weak)IBOutlet UILabel *smartSpaceIDLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceNameLabel;
@property (nonatomic,weak)IBOutlet UITextView *smartSpaceDescriptionTextView;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceStreetLine1Label;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceStreetLine2Label;
@property (nonatomic,weak)IBOutlet UILabel *smartSpacePostalCodeLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceCityLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceStateLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceCountryLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceModifiedAtLabel;
@property (nonatomic,weak)IBOutlet UILabel *smartSpaceCreatedAtLabel;
@property (nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation PDSmartSpaceDetailTableViewController

-(NSDateFormatter*)dateFormatter{
    static NSDateFormatter *__dateFormatter = nil;
    if (__dateFormatter == nil) {
        __dateFormatter = [[NSDateFormatter alloc]init];
        [__dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [__dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }return __dateFormatter;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateUIForSmartSpace:self.space];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateUIForSmartSpace:(PRXSmartSpace*)space{
    
    self.smartSpaceIDLabel.text = space.smartSpaceID;
    self.smartSpaceNameLabel.text = space.name;
    self.title = space.name;
    self.smartSpaceDescriptionTextView.text = space.smartSpaceDescription;
    
    self.smartSpaceStreetLine1Label.text = space.address.streetLine1;
    self.smartSpaceStreetLine2Label.text = space.address.streetLine2;
    self.smartSpacePostalCodeLabel.text = space.address.zipCode;
    self.smartSpaceCityLabel.text = space.address.cityName;
    self.smartSpaceStateLabel.text = space.address.stateAbbrev;
    self.smartSpaceCountryLabel.text = space.address.countryName;
    
    self.smartSpaceCreatedAtLabel.text = [self.dateFormatter stringFromDate:space.createdAt];

    if (space.modifiedAt == nil) {
        self.smartSpaceModifiedAtLabel.text = @"Not motified";
    }else{
        self.smartSpaceModifiedAtLabel.text = [self.dateFormatter stringFromDate:space.modifiedAt];
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewSmartSpaceContent"]) {
        PDSmartSpaceContentTableViewController *contentController = (PDSmartSpaceContentTableViewController*)segue.destinationViewController;
        contentController.space = self.space;
        
    }else if ([segue.identifier isEqualToString:@"ViewSmartSpaceLocation"]){
        PDMapViewController *mapController = (PDMapViewController*)segue.destinationViewController;
        mapController.address = self.space.address;
    }
}


@end
