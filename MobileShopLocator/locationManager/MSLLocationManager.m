//
//  MSLLocationManager.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLLocationManager.h"

@implementation MSLLocationManager

static MSLLocationManager *_currentManager;

#pragma mark - Initialization
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _currentManager = [[MSLLocationManager alloc] init];
    });
}
- (id)init {
    if (_currentManager) { return _currentManager; }
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    _currentManager = self;
    return self;
}

+ (id)currentManager {
    if (!_currentManager) { _currentManager = [[MSLLocationManager alloc] init]; }
    return _currentManager;
}

#pragma mark - Monitoring
- (void)startMonitoringLocation {
    [self.locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopMonitoringLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Location Manager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"ERRORZ");
}

@end
