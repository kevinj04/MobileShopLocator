//
//  MSLTableViewDelegate.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/15/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLTableViewDelegate.h"
#import "MSLBaseTableViewCell.h"

@implementation MSLTableViewDelegate

#pragma mark - Initialization 
- (id)init {
    self = [super init];
    if (self) {
        self.tableCellClass = [MSLBaseTableViewCell class];
        self.productList = [MSLProductList listWithArray:@[]];
    }
    return self;
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productList.items.count;
}

#pragma mark - UITableView DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:@"productItemCell"];
    if (![cell conformsToProtocol:@protocol(MSLTableViewCell)]) { return nil; }
    UITableViewCell<MSLTableViewCell> *tableViewCell = (UITableViewCell<MSLTableViewCell> *)cell;
    MSLProductListItem *listItem = self.productList.items[indexPath.row];
    [tableViewCell updateWithProductListItem:listItem];
    return tableViewCell;
}

@end
