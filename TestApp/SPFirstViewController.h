//
//  SPFirstViewController.h
//  TestApp
//
//  Created by Kevin Jenkins on 11/18/13.
//  Copyright (c) 2013 somethingPointless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSLTableViewDelegate.h"

@interface SPFirstViewController : UIViewController

@property (strong, nonatomic) MSLTableViewDelegate *tableViewDelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
