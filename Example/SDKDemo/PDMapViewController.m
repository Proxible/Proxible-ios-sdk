//
//  PDMapViewController.m
//  SDK Demo
//
//  Created by Howard Seraus on 12/05/14.
//  Copyright (c) 2014 Proxible B.V. All rights reserved.
//

#import "PDMapViewController.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
@import MapKit;

static NSTimeInterval kPDEnterExitAlertDuration = 3.5f;

@interface PDMapViewController () <MKMapViewDelegate>

@property(nonatomic, weak) IBOutlet MKMapView* mapView;

@end

@implementation PDMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showLocationForAdress:self.address];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showLocationForAdress:(PRXAddress*) address
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting location...";

    NSString *fullAddress = [address fullAddress];
    
    CLGeocoder* clg = [[CLGeocoder alloc]init];
    [clg geocodeAddressString:fullAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(!error){
            CLPlacemark* placeMark = [placemarks firstObject];
            CLLocation* loc = placeMark.location;
            CLLocationCoordinate2D _loc = [loc coordinate];
            MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta = 0.15;
            span.longitudeDelta = 0.15;
            region.center = _loc;
            region.span = span;
            annotation.title = fullAddress;
            annotation.coordinate = loc.coordinate;
            [self.mapView addAnnotation:annotation];
            [self.mapView setRegion:region];
        }
        else
        {
            self.mapView.showsUserLocation = YES;
            
            NSLog(@"There was a forward geocoding error\n%@",
                  [error localizedDescription]);
             [TSMessage showNotificationInViewController:self title:@"Error getting location" subtitle:@"There was an error getting the location." type:TSMessageNotificationTypeError duration:kPDEnterExitAlertDuration canBeDismissedByUser:YES];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView * annotationView = [views firstObject];
    id <MKAnnotation> annotation  = annotationView.annotation;
    [mapView setSelectedAnnotations:@[annotation]];
    
}

@end
