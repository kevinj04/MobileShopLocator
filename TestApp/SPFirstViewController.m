//
//  SPFirstViewController.m
//  TestApp
//
//  Created by Kevin Jenkins on 11/18/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import "SPFirstViewController.h"
#import "MSLWebFetcher.h"

@interface SPFirstViewController ()

@end

@implementation SPFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *prodcutListURL = [NSURL URLWithString:@"https://raw.github.com/kevinj04/oldWorldIceTreats/master/menu"];
    [MSLWebFetcher setProductListURL:prodcutListURL];
    self.tableViewDelegate = [[MSLTableViewDelegate alloc] init];
    self.tableViewDelegate.productList = [MSLWebFetcher fetchList];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
