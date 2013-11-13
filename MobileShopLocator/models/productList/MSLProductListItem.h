//
//  MSLProductListItem.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A product list item is initialized with a string with two commas which delimit a product title, 
 description, and URL for an image. If less than three elements are provided, the item is not
 generated.
 */

@interface MSLProductListItem : NSObject

@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *description;
@property (strong, nonatomic) NSString  *imageURLString;

- (id)initWithString:(NSString *)productItemString;
+ (id)itemWithString:(NSString *)productItemString;

@end
