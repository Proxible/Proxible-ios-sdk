//
//  PDSmartSpaceContentTableViewController.m
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 4/8/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDSmartSpaceContentTableViewController.h"
#import "MBProgressHUD.h"

#import "PDMediaContentCell.h"
#import "PDMediaContentDetailViewController.h"
#import "PDTextContentDetailViewController.h"

@interface PDSmartSpaceContentTableViewController ()

@property (nonatomic,strong)PRXContent *content;

@property (nonatomic,strong)NSOperationQueue *imageLoadingOperationQueue;
@property (nonatomic,strong)NSMutableDictionary *facebookUidToImageDownloadOperations;
@property (nonatomic,strong)NSMutableDictionary *mediaImages;
@property (nonatomic,strong)NSIndexPath *selectedIndexPath;

@end

@implementation PDSmartSpaceContentTableViewController

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
    
    [self.refreshControl addTarget:self action:@selector(refreshContentForSmartSpace) forControlEvents:UIControlEventValueChanged];
    
    self.title = self.space.name;
    
    [self loadContentForSmartSpace];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.imageLoadingOperationQueue cancelAllOperations];
}

-(void)loadContentForSmartSpace{
    
    [self.mediaImages removeAllObjects];
    
    self.content = [[PRXContentManager sharedContentManager]contentForSmartSpace:self.space];
    
    [self.tableView reloadData];
    
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

-(void)refreshContentForSmartSpace{
    
    [self.mediaImages removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Content...";
    
    __weak PDSmartSpaceContentTableViewController *_weakSelf = self;
    
    [[PRXContentManager sharedContentManager]getContentForSmartSpace:self.space completion:^(PRXContent *content, NSError *error) {
        PDSmartSpaceContentTableViewController *_strongSelf = _weakSelf;
        if (_strongSelf) {
            
            _strongSelf.content = content;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_strongSelf.tableView reloadData];
                
                if ([_strongSelf.refreshControl isRefreshing]) {
                    [_strongSelf.refreshControl endRefreshing];
                }
            });
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.mediaImages removeAllObjects];
}

-(NSOperationQueue*)imageLoadingOperationQueue{
    if (_imageLoadingOperationQueue == nil) {
        _imageLoadingOperationQueue = [[NSOperationQueue alloc]init];
    }return _imageLoadingOperationQueue;
}

-(NSMutableDictionary*)facebookUidToImageDownloadOperations{
    if (_facebookUidToImageDownloadOperations == nil) {
        _facebookUidToImageDownloadOperations = [[NSMutableDictionary alloc]init];
    }return _facebookUidToImageDownloadOperations;
}

-(NSMutableDictionary*)mediaImages{
    if (_mediaImages == nil) {
        _mediaImages = [[NSMutableDictionary alloc]init];
    }return _mediaImages;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger numberOfSectionsInTableView = 1;
    if (self.content != nil) {
        numberOfSectionsInTableView = 2;
    }
    return numberOfSectionsInTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 1;
    if (self.content !=nil) {
        if (section == 0) {
            numberOfRowsInSection = [[self.content.textContent allValues]count];
        }else if (section == 1){
            numberOfRowsInSection = [[self.content.mediaContent allValues]count];
        }
    }
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const textContentCellIdentifier = @"TextContentCell";
    static NSString *const mediaContentCellIdentifier = @"MediaContentCell";
    static NSString *const emptyContentCellIdentifier = @"EmptyContentCell";
    
    UITableViewCell *cell;
    
    if (self.content != nil) {
        
        NSString *keyName;
        NSString *value;
        
         if (indexPath.section == 0) {
             
             cell = [tableView dequeueReusableCellWithIdentifier:textContentCellIdentifier forIndexPath:indexPath];
             
             keyName = [[self.content.textContent allKeys]objectAtIndex:indexPath.row];
             value = [[self.content.textContent allValues]objectAtIndex:indexPath.row];
             
             cell.detailTextLabel.text = value;
             cell.textLabel.text = keyName;
             
         }else if (indexPath.section == 1){
             
             PDMediaContentCell* mediaCell = (PDMediaContentCell*)[tableView dequeueReusableCellWithIdentifier:mediaContentCellIdentifier forIndexPath:indexPath];
             
             keyName = [[self.content.mediaContent allKeys]objectAtIndex:indexPath.row];
             value = [[self.content.mediaContent allValues]objectAtIndex:indexPath.row];
             
             [mediaCell setMediaContentKey:keyName];
             
             UIImage *image = [self.mediaImages objectForKey:keyName];
             
             if (image != nil) {
                 [mediaCell setMediaContentImage:image];
             }else{
                 
                 //Create a block operation for loading the image into the profile image view
                 NSBlockOperation *loadImageIntoCellOp = [[NSBlockOperation alloc] init];
                 
                 //Define weak operation so that operation can be referenced from within the block without creating a retain cycle
                 __weak NSBlockOperation *weakOp = loadImageIntoCellOp;
                 
                 __weak PDSmartSpaceContentTableViewController *_weakSelf = self;
                 
                 [loadImageIntoCellOp addExecutionBlock:^(void){
                     
                     PDSmartSpaceContentTableViewController *_strongSelf = _weakSelf;
                     
                     if (_strongSelf) {
                         
                         //Some asynchronous work. Once the image is ready, it will load into view on the main queue
                         UIImage *profileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:value]]];
                         
                         [_strongSelf.facebookUidToImageDownloadOperations removeObjectForKey:keyName];
                         
                         if (profileImage != nil) {
                             
                             [_strongSelf.mediaImages setObject:profileImage forKey:keyName];
                             
                             __weak PDSmartSpaceContentTableViewController *_weakSelfExecutionBlock = _strongSelf;
                             
                             [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
                                 
                                 PDSmartSpaceContentTableViewController *_strongSelf = _weakSelfExecutionBlock;
                                 NSBlockOperation *_strongBlockSelf = weakOp;
                                 
                                 if (_strongSelf) {

                                     if (!_strongBlockSelf.isCancelled) {
                                         
                                         if (_strongSelf) {
                                             
                                             PDMediaContentCell *cellToUpdate  = (PDMediaContentCell*)[tableView cellForRowAtIndexPath:indexPath];
                                             
                                             if (cellToUpdate) {
                                                 
                                                 [cellToUpdate setMediaContentImage:profileImage];
                                                 
                                                 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                             }
                                         }
                                     }
                                 }
                             }];
                         }
                     }
                 }];
                 
                 //Save a reference to the operation in an NSMutableDictionary so that it can be cancelled later on
                 if (keyName) {
                     [self.facebookUidToImageDownloadOperations setObject:loadImageIntoCellOp forKey:keyName];
                 }
                 
                 //Add the operation to the designated background queue
                 if (loadImageIntoCellOp) {
                     [self.imageLoadingOperationQueue addOperation:loadImageIntoCellOp];
                 }
             }
             return mediaCell;
         }
        
    }else{
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:emptyContentCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"No content available";
        cell.detailTextLabel.text = @"Pull down to refresh content";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;

    if (indexPath.section == 0) {
         [self performSegueWithIdentifier:@"ViewFullTextContent" sender:self];
    }else if (indexPath.section == 1){
         [self performSegueWithIdentifier:@"ViewFullSizeMediaContent" sender:self];
    }
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.content!=nil) {
        
        NSString *keyName;
        
        if (indexPath.section == 1){
            keyName = [[self.content.mediaContent allKeys]objectAtIndex:indexPath.row];
            
            //Fetch operation that doesn't need executing anymore
            NSBlockOperation *ongoingDownloadOperation = [self.facebookUidToImageDownloadOperations objectForKey:keyName];
            
            if (ongoingDownloadOperation) {
                //Cancel operation and remove from dictionary
                [ongoingDownloadOperation cancel];
                [self.facebookUidToImageDownloadOperations removeObjectForKey:keyName];
            }
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titleForHeaderInSection = nil;
    if (self.content !=nil) {
        if (section == 0) {
            titleForHeaderInSection = @"Text Contents";
        }else if (section == 1){
            titleForHeaderInSection = @"Media Contents";
        }
    }
    return titleForHeaderInSection;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *keyName;
    NSString *value;
    UIImage *image;
    
    if (self.selectedIndexPath.section == 0) {
        
        keyName = [[self.content.textContent allKeys]objectAtIndex:self.selectedIndexPath.row];
        value = [[self.content.textContent allValues]objectAtIndex:self.selectedIndexPath.row];
        
    }else if (self.selectedIndexPath.section == 1){
        
        keyName = [[self.content.mediaContent allKeys]objectAtIndex:self.selectedIndexPath.row];
         image = [self.mediaImages objectForKey:keyName];
    }
    
    
    if ([segue.identifier isEqualToString:@"ViewFullSizeMediaContent"]) {
        PDMediaContentDetailViewController *mediaDetailController = (PDMediaContentDetailViewController*)segue.destinationViewController;
        mediaDetailController.mediaKeyName = keyName;
        mediaDetailController.mediaImage = image;
    }else if ([segue.identifier isEqualToString:@"ViewFullTextContent"]){
        PDTextContentDetailViewController *textDetailController = (PDTextContentDetailViewController*)segue.destinationViewController;
        textDetailController.textContentKeyName = keyName;
        textDetailController.textContent = value;
    }
}

@end
