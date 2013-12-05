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

+ (NSArray *)tweetsFromTimelineData:(NSData *)data error:(NSError *)error {
    NSError *jsonError;
    NSArray *timelineData = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
    if (timelineData) {
        return timelineData;
    }
    else {
        NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
        error = jsonError;
        return nil;
    }
}

+ (MSLProductList *)listFromTimeLineResponseData:(NSData *)data error:(NSError *)error {
    NSArray *timelineData = [MSLTwitterFetcher tweetsFromTimelineData:data error:error];
    if (timelineData) {
        MSLProductList *productList = [[MSLProductList alloc] init];
        productList.items = [MSLTwitterFetcher itemsFromTweetArray:timelineData];
        return productList;
    }
    else {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    }
}

+ (void)fetchTimelineForUser:(NSString *)username withHandler:(void(^)(NSArray *tweetArray, NSError *error))handler {
    ACAccountType *twitterAccountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    if (twitterAccountType == nil) { return; }
    [_accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {

        if (!granted) { return; }

        NSArray *twitterAccounts = [_accountStore accountsWithAccountType:twitterAccountType];
        SLRequest *request = [MSLTwitterFetcher requestTimeLineForUserName:username];
        request.account = twitterAccounts.lastObject;

        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            NSArray *tweetArray = [MSLTwitterFetcher tweetsFromTimelineData:responseData error:error];
            handler(tweetArray, error);
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

+ (NSString *)locationFromTweetArray:(NSArray *)tweetArray {
    NSString *location;
    for (NSDictionary *tweet in tweetArray) {
        if ((location = [MSLTwitterFetcher locationFromTweet:tweet])) { return location; }
    }
    return location;
}

+ (NSString *)locationFromTweet:(NSDictionary *)tweet {
    if ([tweet[@"text"] isEqualToString:@"Stuff."]) {
        return NSStringFromCGPoint([MSLTwitterFetcher coordinateFromTweet:tweet]);
    }
    return nil;
}

+ (CGPoint)coordinateFromTweet:(NSDictionary *)tweet {
    NSDictionary *geoDictionary = tweet[@"geo"];
    NSArray *coordinates = geoDictionary[@"coordinates"];
    if (coordinates) {
        return CGPointMake([coordinates[1] floatValue], [coordinates[0] floatValue]);
    }
    return CGPointZero;
}

#pragma mark - Location Finding
+ (void)fetchLocation {
    [self fetchTimelineForUser:@"Tweetor9000" withHandler:^(NSArray *tweetArray, NSError *error) {

        if (error) { NSLog(@"Failed to fetch timeline. %@", error.localizedDescription); return; }
        NSString *locationString = [MSLTwitterFetcher locationFromTweetArray:tweetArray];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MSLLocationUpdated" object:self userInfo:@{@"MSLLocationUpdated":locationString}];
     }];
}

@end
