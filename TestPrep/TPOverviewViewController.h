//
//  TPOverviewViewController.h
//  TestPrep
//
//  Created by Tad Scritchfield on 4/24/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDataModel.h"
#import "XYPieChart.h"

@interface TPOverviewViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) TPDataModel *data;

@property (weak, nonatomic) IBOutlet XYPieChart *pieChart;
@property (weak, nonatomic) IBOutlet UINavigationItem *label;
@property (weak, nonatomic) IBOutlet UILabel *questionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *startOverButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *studyButton;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

- (void) preserveState;
- (void) restoreState;

@end
