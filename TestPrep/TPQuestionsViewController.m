//
//  TPQuestionsViewController.m
//  TestPrep
//
//  Created by Tad Scritchfield on 4/23/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPQuestionsViewController.h"
#import "TPAnswer.h"
#import "TPNumbersViewController.h"

@interface TPQuestionsViewController ()

@end

@implementation TPQuestionsViewController
{
    NSMutableArray *_answers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _numberOfQuestions = _data.questions.count;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    _data.currentNumber = _goToQuestion;
    [self updateData];
    _backButton.titleLabel.font = [UIFont fontWithName:@"Samba" size:18];
    _nextButton.titleLabel.font = [UIFont fontWithName:@"Samba" size:18];
    _questionNumberLabel.font = [UIFont fontWithName:@"Samba" size:22];
    _answerLabel.font = [UIFont fontWithName:@"Samba" size:22];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender
{
    _data.currentNumber++;
    [self updateData];
    
}

- (IBAction)back:(id)sender
{
    _data.currentNumber--;
    [self updateData];
}

- (IBAction)answerQuestion:(id)sender
{
    NSString *userAnswer = (NSString *)_answerField.text;
    NSString *answer = (NSString *)_data.questions[_data.currentNumber][1];
    userAnswer = [userAnswer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    answer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    userAnswer = [userAnswer lowercaseString];
    answer = [answer lowercaseString];
    
    //NSLog(@"%@", answer);
    //NSLog(@"%@", userAnswer);
    
    if ([userAnswer isEqualToString:answer])
    {
        _answerLabel.textColor = [UIColor greenColor];
        _answerLabel.text = @"Correct!";
        [_data.qsAnswered replaceObjectAtIndex:_data.currentNumber withObject:[[TPAnswer alloc] initWithAnswer:userAnswer answered:YES correct:YES]];
        _answerField.enabled = NO;
        //NSLog(@"%@", _data.qsAnswered);
    }
    else
    {
        _answerLabel.textColor = [UIColor redColor];
        _answerLabel.text = [NSString stringWithFormat:@"Inncorect: %@", answer];
        [_data.qsAnswered replaceObjectAtIndex:_data.currentNumber withObject:[[TPAnswer alloc] initWithAnswer:userAnswer answered:YES correct:NO]];
        _answerField.enabled = NO;
    }
    
    _explainationView.text = _data.questions[_data.currentNumber][2];
    
    _parentController.data = _data;
    [_parentController preserveState];
}

- (void)updateData
{
    _questionNumberLabel.text = [NSString stringWithFormat:@"Question %i of %i", _data.currentNumber+1, _numberOfQuestions];
    _textView.text = _data.questions[_data.currentNumber][0];
    
    TPAnswer *object = [_data.qsAnswered objectAtIndex:_data.currentNumber];
    if (object.answered)
    {
        _answerField.enabled = NO;
        _answerField.text = object.userAnswer;
        _explainationView.text = _data.questions[_data.currentNumber][2];
        if (object.correct)
        {
            _answerLabel.textColor = [UIColor greenColor];
            _answerLabel.text = @"Correct!";
        }
        else
        {
            _answerLabel.textColor = [UIColor redColor];
            _answerLabel.text = [NSString stringWithFormat:@"Inncorect: %@", (NSString *)_data.questions[_data.currentNumber][1]];
        }
    }
    else
    {
        _answerField.enabled = YES;
        _answerField.text = @"";
        _answerLabel.text = @"";
        _explainationView.text = @"";
        
    }
    
    if (_data.currentNumber+1 >= _numberOfQuestions)
    {
        _nextButton.enabled = NO;
    }
    else
    {
        _nextButton.enabled = YES;
    }
    
    if (_data.currentNumber <= 0)
    {
        _backButton.enabled = NO;
    }
    else
    {
        _backButton.enabled = YES;
    }
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TPNumbersViewController *numberController = segue.destinationViewController;
    numberController.numberOfQuestions = _numberOfQuestions;
    numberController.parentController = self;
}

@end
