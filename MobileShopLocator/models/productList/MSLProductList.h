//
//  MSLProductList.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLProductListItem.h"

@interface MSLProductList : NSObject

@property (strong, nonatomic) NSArray *items;

- (id)initWithString:(NSString *)menuString;
- (id)initWithArray:(NSArray *)menuArray;
+ (id)listWithString:(NSString *)menuString;
+ (id)listWithArray:(NSArray *)menuArray;

@end
