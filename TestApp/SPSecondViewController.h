//
//  SPSecondViewController.h
//  TestApp
//
//  Created by Kevin Jenkins on 11/18/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SPSecondViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
