//
//  MSLAnnotation.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/21/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLAnnotation.h"

@implementation MSLAnnotation

#pragma mark - Initialization
- (id)init {
    self = [super init];
    return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [self init];
    if (self) {
        self.coordinate = coordinate;
    }
    return self;
}

@end
