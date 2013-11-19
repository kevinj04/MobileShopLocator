//
//  MSLBaseTableViewCell.m
//  MobileShopLocator
//
//  Created by Kevin Jenkins on 11/15/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "MSLBaseTableViewCell.h"
#import "MSLProductListItem.h"

NSString *const MSLTableViewCellImageRetrieved = @"MSLTableViewCellImageRetrieved";

@implementation MSLBaseTableViewCell

#pragma mark - Initialization
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - MSLTableViewCell Protocol
- (void)updateWithProductListItem:(MSLProductListItem *)item {
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.description;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageRetrieved:) name:MSLTableViewCellImageRetrieved object:self];
    
    NSURL *url = [NSURL URLWithString:item.imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            // handle connection error
        } else {
            UIImage *image = [UIImage imageWithData:data];
            [[NSNotificationCenter defaultCenter] postNotificationName:MSLTableViewCellImageRetrieved object:self userInfo:@{MSLTableViewCellImageRetrieved:image}];
        }
    }];
}

#pragma mark - Image Retrieval Methods
- (void)imageRetrieved:(NSNotification *)notification {
    self.imageView.image = notification.userInfo[MSLTableViewCellImageRetrieved];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
