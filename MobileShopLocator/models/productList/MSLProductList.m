//
//  MSLProductList.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLProductList.h"

@implementation MSLProductList

#pragma mark - Initialization
- (id)initWithString:(NSString *)menuString {
    NSArray *menuArray = [menuString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return [self initWithArray:menuArray];
}

- (id)initWithArray:(NSArray *)menuArray {
    if (menuArray == nil) { return nil; }
    self = [super init];
    if (self) {
        [self setupWithArray:menuArray];
    }
    return self;
}

+ (id)listWithString:(NSString *)menuString {
    return [[MSLProductList alloc] initWithString:menuString];
}

+ (id)listWithArray:(NSArray *)menuArray {
    return [[MSLProductList alloc] initWithArray:menuArray];
}

- (void)setupWithArray:(NSArray *)menuArray {
    self.items = [self entriesFromMenuArray:menuArray];
}

#pragma mark - Menu Parsing
- (NSArray *)entriesFromMenuArray:(NSArray *)menuArray {
    NSMutableArray *menuItems = @[].mutableCopy;
    for (NSString *entryLine in menuArray) {
        if ([entryLine hasPrefix:@"#"]) { continue; }
        MSLProductListItem *menuItem = [MSLProductListItem itemWithString:entryLine];
        [menuItems addObject:menuItem];
    }
    return [NSArray arrayWithArray:menuItems];
}


@end
