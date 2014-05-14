//
//  PDSmartSpaceSelectionTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpaceSelectionTableViewController.h"
#import "PDSmartSpaceDescriptionTableViewCell.h"
#import "MBProgressHUD.h"

@interface PDSmartSpaceSelectionTableViewController ()

@property (nonatomic,strong)NSArray *allSmartSpaces;
@property (nonatomic,strong)NSMutableSet *selectedSmartSpaces;

-(IBAction)doneSelectingSmartSpaces:(id)sender;
-(IBAction)cancelSmartSpaceSelecting:(id)sender;
@end

@implementation PDSmartSpaceSelectionTableViewController

-(NSMutableSet*)selectedSmartSpaces{
    if (_selectedSmartSpaces == nil) {
        _selectedSmartSpaces = [[NSMutableSet alloc]init];
    }return _selectedSmartSpaces;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add pull-down-to-refresh
    [self.refreshControl addTarget:self action:@selector(reloadSmartSpaces) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Load all smart spaces from disk
    [self loadSmartSpacesPreferCached:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneSelectingSmartSpaces:(id)sender{
    if ([self.delegate respondsToSelector:@selector(selectionController:didSelectSmartSpaces:)]) {
        [self.delegate selectionController:self didSelectSmartSpaces:[self.selectedSmartSpaces allObjects]];
    }
}

-(IBAction)cancelSmartSpaceSelecting:(id)sender{
    if ([self.delegate respondsToSelector:@selector(selectionControllerDidCancelSelection:)]) {
        [self.delegate selectionControllerDidCancelSelection:self];
    }
}

#pragma mark - Loading/Reloading

-(void)reloadSmartSpaces{
    [self loadSmartSpacesPreferCached:NO];
}

-(void)loadSmartSpacesPreferCached:(BOOL)preferCached{
    
    if (preferCached) {
        self.allSmartSpaces = [[PRXSmartSpaceManager sharedSmartSpaceManager]allSmartSpaces];
        [self.tableView reloadData];
    }
    else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading Smart Spaces...";
        
        __weak PDSmartSpaceSelectionTableViewController * _weakSelf = self;
        
        [[PRXSmartSpaceManager sharedSmartSpaceManager]getAllSmartSpacesWithCompletion:^(NSArray *smartSpaces, NSError *error) {
            PDSmartSpaceSelectionTableViewController *_strongSelf = _weakSelf;
            if (_strongSelf) {
                
                if (error != nil) {
                    
                }else{
                    _strongSelf.allSmartSpaces = smartSpaces;
                }
                
                [MBProgressHUD hideHUDForView:_strongSelf.view animated:YES];
                
                [_strongSelf.tableView reloadData];
                
                if ([_strongSelf.refreshControl isRefreshing]) {
                    [_strongSelf.refreshControl endRefreshing];
                }
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allSmartSpaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SmartSpaceDescriptionCell";
    PDSmartSpaceDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRXSmartSpace *space = [self.allSmartSpaces objectAtIndex:indexPath.row];
    
    [cell configureCellWithSmartSpace:space];
    if ([self.selectedSmartSpaces containsObject:space]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PRXSmartSpace *space = [self.allSmartSpaces objectAtIndex:indexPath.row];
    
    if ([self.selectedSmartSpaces containsObject:space]) {
        [self.selectedSmartSpaces removeObject:space];
    }else{
        [self.selectedSmartSpaces addObject:space];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
