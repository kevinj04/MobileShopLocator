//
//  MSLTableViewDelegate.h
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/15/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSLProductList.h"

@interface MSLTableViewDelegate : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) Class tableCellClass;
@property (strong, nonatomic) MSLProductList *productList;

@end
