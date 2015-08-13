//
//  TPNumbersViewController.h
//  TestPrep
//
//  Created by Tad Scritchfield on 6/5/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPQuestionsViewController.h"

@interface TPNumbersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) TPQuestionsViewController *parentController;
@property (nonatomic) int questionNumber;
@property (nonatomic) int numberOfQuestions;

@end
