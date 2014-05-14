//
//  PDRangingTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDRangingTableViewController.h"
#import "PDSmartSpaceSelectionTableViewController.h"
#import "PDBeaconCell.h"
#import "TSMessage.h"

static NSTimeInterval kPDEnterExitAlertDuration = 3.5f;

@interface PDRangingTableViewController ()<PRXLocationManagerDelegate,PDSmartSpaceSelectionTableViewControllerDelegate>

@property (nonatomic,strong)PRXLocationManager *locationManager;
@property (nonatomic,strong)NSMutableDictionary *beacons;
@property (nonatomic,strong)NSSortDescriptor *beaconProximitySorter;

@end

@implementation PDRangingTableViewController

-(NSSortDescriptor*)beaconProximitySorter{
    if (_beaconProximitySorter == nil) {
        _beaconProximitySorter = [[NSSortDescriptor alloc]initWithKey:@"proximity" ascending:YES];
    }return _beaconProximitySorter;
}

-(NSMutableDictionary*)beacons{
    if (_beacons == nil) {
        _beacons = [[NSMutableDictionary alloc]init];
    }return _beacons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[PRXLocationManager alloc]initWithDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([PRXLocationManager proximityServicesEnabled]) {
        NSArray *smartSpaces = [[self.locationManager rangedSmartSpaces]allObjects];
        [self startRangingBeaconsInSmartSpaces:smartSpaces];
    }else{
        [TSMessage showNotificationInViewController:self title:@"Proximity Services Unavailable" subtitle:@"Proximity services are unavailable turn on location services/BLE to start ranging" type:TSMessageNotificationTypeError duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
    }
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSArray *smartSpaces = [[self.locationManager rangedSmartSpaces]allObjects];
    [self stopRangingBeaconsInSmartSpaces:smartSpaces];
    [self.beacons removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectionController:(PDSmartSpaceSelectionTableViewController *)controller didSelectSmartSpaces:(NSArray *)selectedSmartSpaces{
    
    if ([PRXLocationManager proximityServicesEnabled]) {
        [self startRangingBeaconsInSmartSpaces:selectedSmartSpaces];
        
    }else{
        [TSMessage showNotificationInViewController:self title:@"Proximity Services Unavailable" subtitle:@"Proximity services are unavailable turn on location services/BLE to start monitoring" type:TSMessageNotificationTypeError duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionControllerDidCancelSelection:(PDSmartSpaceSelectionTableViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)startRangingBeaconsInSmartSpaces:(NSArray*)spaces{
    
    [spaces enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PRXSmartSpace *space = (PRXSmartSpace*)obj;
        [self.locationManager startRangingBeaconsInSmartSpace:space];
    }];
}

-(void)stopRangingBeaconsInSmartSpaces:(NSArray*)spaces{
    
    [spaces enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PRXSmartSpace *space = (PRXSmartSpace*)obj;
        [self.locationManager stopRangingBeaconsInSmartSpace:space];
    }];
}

- (void)locationManager:(PRXLocationManager*)manager didRangeBeacons:(NSArray*)beacons inSmartSpace:(PRXSmartSpace*)space{
    
    NSMutableArray *beaconsForSmartSpace = [self.beacons objectForKey:space.name];
    
    if (beaconsForSmartSpace == nil) {
        beaconsForSmartSpace = [[NSMutableArray alloc]init];
    }
    [beaconsForSmartSpace removeAllObjects];
    [beaconsForSmartSpace addObjectsFromArray:beacons];
    [beaconsForSmartSpace sortUsingDescriptors:@[self.beaconProximitySorter]];
    [self.beacons setObject:beaconsForSmartSpace forKey:space.name];
    
    [self.tableView reloadData];
    
}

- (void)locationManager:(PRXLocationManager*)manager rangingBeaconsDidFailForSmartSpace:(PRXSmartSpace*)space withError:(NSError *)error{
    
}

-(void)locationManager:(PRXLocationManager *)manager didUpdateProximityServicesAvailibility:(BOOL)available{
}

-(void)locationManager:(PRXLocationManager*)manager didFailWithError:(NSError*)error{
    NSLog(@"Error:%@",[error localizedDescription]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.beacons count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionValues = [self.beacons allValues];
    NSInteger beaconsInsections = [[sectionValues objectAtIndex:section] count];
    
    NSInteger numberOfRowsInSection = 1;
    if (beaconsInsections > 0) {
        numberOfRowsInSection = beaconsInsections;
    }
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
     static NSString *EmprtyCellIdentifier = @"EmptyCell";
    
    NSArray *sectionValues = [self.beacons allValues];
    NSInteger beaconsInsections = [[sectionValues objectAtIndex:indexPath.section] count];
    if (beaconsInsections > 0) {
        PDBeaconCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString *smartSpaceName = [[self.beacons allKeys]objectAtIndex:indexPath.section];
        NSArray *beacons = [self.beacons objectForKey:smartSpaceName];
        PRXBeacon *beacon = [beacons objectAtIndex:indexPath.row];
        
        [cell configureCellWithBeacon:beacon];
        
        return cell;
    }
    
    UITableViewCell *emptyCell = [tableView dequeueReusableCellWithIdentifier:EmprtyCellIdentifier forIndexPath:indexPath];
    emptyCell.textLabel.text = @"No beacons in proximity";
    emptyCell.detailTextLabel.text = @"Once in proximity beacons will appear";
    return emptyCell;
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *smartSpaceName = [[self.beacons allKeys]objectAtIndex:section];
    return [NSString stringWithFormat:@"Smart Space: %@",smartSpaceName];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddSmartSpaces"]) {
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        PDSmartSpaceSelectionTableViewController *selectionController = (PDSmartSpaceSelectionTableViewController*)[navController topViewController];
        selectionController.delegate = self;
    }
}

@end
