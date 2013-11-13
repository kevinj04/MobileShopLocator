//
//  MSLWebFetcher.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLWebFetcher.h"

static NSURL *_productListURL;

@implementation MSLWebFetcher

#pragma mark - Settings
+ (void)setProductListURL:(NSURL *)productListURL {
    _productListURL = productListURL;
}

#pragma mark - Product Fetcher Methods
+ (MSLProductList *)fetchList {
    NSURLRequest *request = [NSURLRequest requestWithURL:_productListURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSHTTPURLResponse   *response;
    NSError             *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (response.statusCode == 200) {
        NSString *responseString = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        return [MSLProductList listWithString:responseString];
    } else {
        return nil;
    }
}

+ (void)fetchListWithCompletionHandler:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))handler {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_productListURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

@end
