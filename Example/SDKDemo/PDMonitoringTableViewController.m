//
//  PDMonitoringTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDMonitoringTableViewController.h"
#import "PDSmartSpaceMonitoredCell.h"
#import "PDSmartSpaceSelectionTableViewController.h"
#import "TSMessage.h"

static NSTimeInterval kPDEnterExitAlertDuration = 3.5f;

@interface PDMonitoringTableViewController ()<PRXLocationManagerDelegate, PDSmartSpaceSelectionTableViewControllerDelegate>

@property (nonatomic,strong)PRXLocationManager *locationManager;
@property (nonatomic,strong)NSMutableDictionary *monitoredSmartSpaces;

@end

@implementation PDMonitoringTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[PRXLocationManager alloc]initWithDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Get current monitored smart spaces
    NSArray *smartspaces = [[self.locationManager monitoredSmartSpaces]allObjects];
    self.monitoredSmartSpaces = [NSMutableDictionary dictionaryWithObjects:smartspaces forKeys:[smartspaces valueForKey:@"smartSpaceID"]];
    [self.tableView reloadData];
    
    if (![PRXLocationManager proximityServicesEnabled]) {
        
        [TSMessage showNotificationInViewController:self title:@"Proximity Services Unavailable" subtitle:@"Proximity services are unavailable turn on location services/BLE to start monitoring" type:TSMessageNotificationTypeError duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectionController:(PDSmartSpaceSelectionTableViewController *)controller didSelectSmartSpaces:(NSArray *)selectedSmartSpaces{
    
    if ([PRXLocationManager proximityServicesEnabled]) {
        
        [selectedSmartSpaces enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PRXSmartSpace *space = (PRXSmartSpace*)obj;
            [self.monitoredSmartSpaces setObject:space forKey:space.smartSpaceID];
            
            if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
                [self.locationManager requestAlwaysAuthorization];
            }
            
            [self.locationManager startMonitoringForSmartSpace:space];
        }];
        
    }else{
        
        [TSMessage showNotificationInViewController:self title:@"Proximity Services Unavailable" subtitle:@"Proximity services are unavailable turn on location services/BLE to start monitoring" type:TSMessageNotificationTypeError duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
    }
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectionControllerDidCancelSelection:(PDSmartSpaceSelectionTableViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PRXLocationManagerDelegate

-(void)locationManager:(PRXLocationManager *)manager didDetermineState:(PRXSmartSpaceState)state forSmartSpace:(PRXSmartSpace *)space{
    
    [self.monitoredSmartSpaces setObject:space forKey:space.smartSpaceID];
    [self.tableView reloadData];
}

-(void)locationManager:(PRXLocationManager *)manager didEnterSmartSpace:(PRXSmartSpace *)space{
    
    [self.monitoredSmartSpaces setObject:space forKey:space.smartSpaceID];
    [self.tableView reloadData];
    
    NSString *title = [NSString stringWithFormat:@"Did enter smart space %@",space.name];
    
    [TSMessage showNotificationInViewController:self title:title subtitle:nil type:TSMessageNotificationTypeMessage duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
}

-(void)locationManager:(PRXLocationManager *)manager didExitSmartSpace:(PRXSmartSpace *)space{
    
    [self.monitoredSmartSpaces setObject:space forKey:space.smartSpaceID];
    [self.tableView reloadData];
    
    NSString *title = [NSString stringWithFormat:@"Did exit smart space %@",space.name];
    NSString *subTile = [NSString stringWithFormat:@"Time spent in smart space %2.0f",space.timeSpentInSmartSpace];
    
    [TSMessage showNotificationInViewController:self title:title subtitle:subTile type:TSMessageNotificationTypeMessage duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
}

-(void)locationManager:(PRXLocationManager *)manager didStartMonitoringForSmartSpace:(PRXSmartSpace *)space{
    NSLog(@"locationManager:%@ didStartMonitoringForSmartSpace:%@ ",manager,space);
}

-(void)locationManager:(PRXLocationManager *)manager didStopMonitoringForSmartSpace:(PRXSmartSpace *)space{
    NSLog(@"locationManager:%@ didStopMonitoringForSmartSpace:%@ ",manager,space);
}

-(void)locationManager:(PRXLocationManager *)manager monitoringDidFailForSmartSpace:(PRXSmartSpace *)space withError:(NSError *)error{
    NSLog(@"locationManager:%@ monitoringDidFailForSmartSpace:%@ ",manager,space);
}

-(void)locationManager:(PRXLocationManager *)manager didUpdateProximityServicesAvailibility:(BOOL)available{
    
    if (available) {
        
    }
}

-(void)locationManager:(PRXLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"LocationManager:%@ didFailWithError:%@",manager,[error localizedDescription]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.monitoredSmartSpaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SmartSpaceCell";
    PDSmartSpaceMonitoredCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRXSmartSpace *space = [[self.monitoredSmartSpaces allValues] objectAtIndex:indexPath.row];
    
    [cell configureCellWithSmartSpace:space];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        PRXSmartSpace *space = [[self.monitoredSmartSpaces allValues] objectAtIndex:indexPath.row];
        [self.locationManager stopMonitoringForSmartSpace:space];
        [self.monitoredSmartSpaces removeObjectForKey:space.smartSpaceID];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
