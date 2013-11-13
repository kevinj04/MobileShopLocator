//
//  MSLProductFetcher.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLProductList.h"

@protocol MSLProductFetcher <NSObject>

+ (MSLProductList *)fetchList;
+ (void)fetchListWithCompletionHandler:(void(^)(MSLProductList *productList, NSError *error))handler;

@end
