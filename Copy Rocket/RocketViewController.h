//
//  ViewController.h
//  Copy Rocket
//
//  Created by Stef Thoen on 12-08-12.
//  Copyright (c) 2012 Stef Thoen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "AFNetworking.h"

@interface RocketViewController : PullRefreshTableViewController <UITableViewDataSource>
{
    __weak IBOutlet UITableView *rocketTableView;
    __weak IBOutlet UITextField *emailTextField;
}

- (void)didReceiveNewDataFromPasteboard:(UIPasteboard *)pasteboard;

@end
