//
//  MSLProductListItem.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLProductListItem.h"

@implementation MSLProductListItem

#pragma mark - Initialization
- (id)initWithString:(NSString *)menuItemString {
    if (menuItemString == nil) { return nil; }
    self = [super init];
    if (self) {
        [self setupWithString:menuItemString];
    }
    return self;
}

+ (id)itemWithString:(NSString *)menuItemString {
    return [[MSLProductListItem alloc] initWithString:menuItemString];
}

- (void)setupWithString:(NSString *)menuItemString {
    NSArray *elements = [menuItemString componentsSeparatedByString:@","];
    if (elements.count < 3) { return; }
    self.title = elements[0];
    self.description = elements[1];
    self.imageURLString = elements[2];
}

#pragma mark - Getters
- (NSString *)imageURLString {
    NSString *urlString = [_imageURLString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
