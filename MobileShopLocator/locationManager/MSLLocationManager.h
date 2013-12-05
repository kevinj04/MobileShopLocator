//
//  MSLLocationManager.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MSLLocationManager : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation        *currentLocation;
@property (strong, nonatomic) CLLocation        *storeLocation;

+ (MSLLocationManager *)currentManager;
- (void)startMonitoringLocation;
- (void)stopMonitoringLocation;

@end
