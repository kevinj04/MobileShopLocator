//
//  MSLAnnotation.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/21/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MSLAnnotation : NSObject<MKAnnotation>

@property (assign, nonatomic) CLLocationCoordinate2D    coordinate;
@property (copy, nonatomic)   NSString                  *title;
@property (copy, nonatomic)   NSString                  *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
