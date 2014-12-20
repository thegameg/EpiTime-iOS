//
//  ETGroupsViewController.h
//  EpiTime
//
//  Created by Francis Visoiu Mistrih on 19/12/2014.
//  Copyright (c) 2014 EpiTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETGroupsViewController : UIViewController <UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end