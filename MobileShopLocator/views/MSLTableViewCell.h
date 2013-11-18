//
//  MSLTableViewCell.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/15/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLProductListItem.h"

@protocol MSLTableViewCell<NSObject>

- (void)updateWithProductListItem:(MSLProductListItem *)item;

@end
