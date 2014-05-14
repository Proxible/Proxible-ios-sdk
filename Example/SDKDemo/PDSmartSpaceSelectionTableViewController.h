//
//  PDSmartSpaceSelectionTableViewController.h
//  SDK Demo
//
//  Created by Conrad Bartels Daal on 5/11/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDSmartSpaceSelectionTableViewController;

@protocol PDSmartSpaceSelectionTableViewControllerDelegate <NSObject>

-(void)selectionController:(PDSmartSpaceSelectionTableViewController*)controller didSelectSmartSpaces:(NSArray*)selectedSmartSpaces;

-(void)selectionControllerDidCancelSelection:(PDSmartSpaceSelectionTableViewController *)controller;

@end


@interface PDSmartSpaceSelectionTableViewController : UITableViewController

@property (nonatomic,weak)id<PDSmartSpaceSelectionTableViewControllerDelegate>delegate;

@end
