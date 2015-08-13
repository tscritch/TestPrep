//
//  TPQuestionsViewController.h
//  TestPrep
//
//  Created by Tad Scritchfield on 4/23/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDataModel.h"
#import "TPOverviewViewController.h"

@interface TPQuestionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *explainationView;
@property (weak, nonatomic) IBOutlet UITextField *answerField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)answerQuestion:(id)sender;

@property (strong, nonatomic) TPDataModel *data;
@property (strong, nonatomic) TPOverviewViewController *parentController;
@property (nonatomic) int numberOfQuestions;
@property (nonatomic) int goToQuestion;

@end
