//
//  PDSmartSpacesListTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpacesListTableViewController.h"
#import "PDSmartSpaceDescriptionTableViewCell.h"
#import "PDSmartSpaceDetailTableViewController.h"
#import "MBProgressHUD.h"

@interface PDSmartSpacesListTableViewController ()

@property (nonatomic,strong)NSArray *allSmartSpaces;
@property (nonatomic,strong)PRXSmartSpace *selectedSmartSpace;

-(void)loadSmartSpacesPreferCached:(BOOL)preferCached;

@end

@implementation PDSmartSpacesListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add pull-down-to-refresh
    [self.refreshControl addTarget:self action:@selector(reloadSmartSpaces) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Load available smart spaces
    [self loadSmartSpacesPreferCached:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        __weak PDSmartSpacesListTableViewController * _weakSelf = self;
        
        [[PRXSmartSpaceManager sharedSmartSpaceManager]getAllSmartSpacesWithCompletion:^(NSArray *smartSpaces, NSError *error) {
            PDSmartSpacesListTableViewController *_strongSelf = _weakSelf;
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
    // Return the number of rows in the section.
    return [self.allSmartSpaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SmartSpaceDescriptionCell";
    PDSmartSpaceDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PRXSmartSpace *space = [self.allSmartSpaces objectAtIndex:indexPath.row];
    
    [cell configureCellWithSmartSpace:space];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedSmartSpace = [self.allSmartSpaces objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewSmartSpaceDetail" sender:self];
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewSmartSpaceDetail"]) {
        
        PDSmartSpaceDetailTableViewController *detailController = (PDSmartSpaceDetailTableViewController*)segue.destinationViewController;
        detailController.space = self.selectedSmartSpace;
    }
}
@end
