//
//  MSLTwitterFetcher.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/13/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLTwitterFetcher.h"
#import "MSLProductList.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

static ACAccountStore *_accountStore;

@implementation MSLTwitterFetcher

#pragma mark - Settings
+ (void)setup {
    _accountStore = [[ACAccountStore alloc] init];
}

#pragma mark - Product Fetcher Methods
+ (MSLProductList *)fetchList {
    return nil;
}

+ (void)fetchListWithCompletionHandler:(void(^)(MSLProductList *productList, NSError *error))handler {
    
}

#pragma mark - Twitter Methods
+ (SLRequest *)requestTimeLineForUserName:(NSString *)userName {
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
    NSDictionary *params = @{@"screen_name" : userName,
                             @"include_rts" : @"0",
                             @"trim_user" : @"1",
                             @"count" : @"10"};
    SLRequest *request =
    [SLRequest requestForServiceType:SLServiceTypeTwitter
                       requestMethod:SLRequestMethodGET
                                 URL:url
                          parameters:params];
    return request;
}

+ (MSLProductList *)listFromTimeLineResponseData:(NSData *)data error:(NSError *)error {
    
    NSError *jsonError;
    NSArray *timelineData = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
    if (timelineData) {
        MSLProductList *productList = [[MSLProductList alloc] init];
        productList.items = [MSLTwitterFetcher itemsFromTweetArray:timelineData];
        return productList;
    }
    else {
        NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
        return nil;
    }
}

+ (void)fetchTimelineForUser:(NSString *)username withHandler:(void(^)(MSLProductList *productList, NSError *error))handler {

    ACAccountType *twitterAccountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    if (twitterAccountType == nil) { return; }
    
    [_accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
        
        if (!granted) { return; }
        
        NSArray *twitterAccounts = [_accountStore accountsWithAccountType:twitterAccountType];
        SLRequest *request = [MSLTwitterFetcher requestTimeLineForUserName:username];
        request.account = twitterAccounts.lastObject;

        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            
            MSLProductList *productList = nil;
            if (!error) {
                productList = [MSLTwitterFetcher listFromTimeLineResponseData:responseData error:error];
            }
            handler(productList, error);
            
         }];
    }];
}


#pragma mark - Tweet Processing
+ (NSArray *)itemsFromTweetArray:(NSArray *)tweetArray {
    NSMutableArray *items = @[].mutableCopy;
    for (NSDictionary *tweet in tweetArray) {
        MSLProductListItem *item = [MSLTwitterFetcher itemFromTweet:tweet];
        if (item) { [items addObject:item]; }
    }
    return [NSArray arrayWithArray:items];
}

+ (MSLProductListItem *)itemFromTweet:(NSDictionary *)tweet {
    NSString *tweetString = tweet[@"text"];
    if ([tweetString hasPrefix:@"&gt;"]) {
        tweetString = [[tweetString substringFromIndex:3] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        return [MSLProductListItem itemWithString:tweetString];
    }
    return nil;
}

@end
