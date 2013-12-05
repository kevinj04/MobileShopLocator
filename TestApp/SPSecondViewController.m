//
//  SPSecondViewController.m
//  TestApp
//
//  Created by Kevin Jenkins on 11/18/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "SPSecondViewController.h"
#import "MSLLocationManager.h"
#import "MSLAnnotation.h"
#import <MapKit/MapKit.h>

@interface SPSecondViewController ()

@end

@implementation SPSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    [self.mapView addAnnotation:[self annotation]];
    [self.mapView addAnnotation:[self storeAnnotation]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Annotations
- (id<MKAnnotation>)annotation {
    CLLocationCoordinate2D coordinate = [[[MSLLocationManager currentManager] currentLocation] coordinate];
    MSLAnnotation *annotation = [[MSLAnnotation alloc] initWithCoordinate:coordinate];
    annotation.title = @"hello";
    annotation.subtitle = @"yum!";
    return annotation;
}

- (id<MKAnnotation>)storeAnnotation {
    CLLocationCoordinate2D coordinate = [[[MSLLocationManager currentManager] storeLocation] coordinate];
    MSLAnnotation *annotation = [[MSLAnnotation alloc] initWithCoordinate:coordinate];
    annotation.title = @"THE STORE";
    annotation.subtitle = @"yum!";
    return annotation;
}

#pragma mark - Map View Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10000, 10000);
    [self.mapView setRegion:region animated:YES];
}


@end
