//
//  TPCoursesTableViewController.h
//  TestPrep
//
//  Created by Tad Scritchfield on 4/23/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPCoursesTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *list;

@end
