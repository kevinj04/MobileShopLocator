//
//  MSLTwitterFetcher.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLProductFetcher.h"

@interface MSLTwitterFetcher : NSObject<MSLProductFetcher>

+ (void)setup;
+ (void )fetchLocation;

@end
