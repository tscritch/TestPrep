//
//  TPOverviewViewController.m
//  TestPrep
//
//  Created by Tad Scritchfield on 4/24/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPOverviewViewController.h"
#import "TPQuestionsViewController.h"
#import "TPAnswer.h"
#import <QuartzCore/QuartzCore.h>

@implementation TPOverviewViewController
{
    int _firstUnanswered;
    NSMutableArray *_array;
    BOOL hasStarted;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    hasStarted = [userDefaults boolForKey:[NSString stringWithFormat:@"%@started", _label.title]];
    if (!hasStarted)
    {*/
        _data = [[TPDataModel alloc] initWithQuestions:[self getQuestions:_label.title] answers:[[NSMutableArray alloc] init] number:0 studyMissed:NO];
    //}
    
    
    self.slices = [NSMutableArray arrayWithCapacity:3];
    
    for(int i = 0; i < 3; i ++)
    {
        if (i==0)
        {
            NSNumber *one = [NSNumber numberWithInt:0]; //right
            [_slices addObject:one];
        }
        else if (i==1)
        {
            NSNumber *one = [NSNumber numberWithInt:0]; //unanswered
            [_slices addObject:one];
        }
        else if (i==2)
        {
            NSNumber *one = [NSNumber numberWithInt:0]; // wrong
            [_slices addObject:one];
        }
        
    }
    
    [self.pieChart setDataSource:self];
    [self.pieChart setStartPieAngle:M_PI_2];
    [self.pieChart setAnimationSpeed:1.0];
    [self.pieChart setLabelFont:[UIFont fontWithName:@"Samba" size:26]];
    [self.pieChart setLabelRadius:40];
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:0.2]];
    [self.pieChart setPieCenter:CGPointMake(106, 106)];
    [self.pieChart setUserInteractionEnabled:YES];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:72/255.0 green:222/255.0 blue:61/255.0 alpha:0.5],
                       [UIColor colorWithRed:80/255.0 green:189/255.0 blue:245/255.0 alpha:0.5],
                       [UIColor colorWithRed:185/255.0 green:0/255.0 blue:42/255.0 alpha:0.5],nil];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self restoreState];
    [self updateSliceData];
    int answeredQs = [self numberOfAnswered];
    //int right = [self rightAnswers];
    //int wrong = [self wrongAnswers];
    int count = _data.questions.count;
    
    _background.image = [UIImage imageNamed:_label.title];
    
    _questionsLabel.font = [UIFont fontWithName:@"Samba" size:20];
    _questionsLabel.text = [NSString stringWithFormat:@"Questions Answered: %i of %i", answeredQs, count];
    
    _startOverButton.titleLabel.font = [UIFont fontWithName:@"Samba" size:26];
    _continueButton.titleLabel.font = [UIFont fontWithName:@"Samba" size:26];
    _studyButton.titleLabel.font = [UIFont fontWithName:@"Samba" size:26];
    
    if (answeredQs > 0)
    {
        _continueButton.enabled = YES;
    }
    else
    {
        _continueButton.enabled = NO;
    }
    
}
- (void)viewDidUnload
{
    [self setPieChart:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self resetSlices];
    [self.pieChart reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TPQuestionsViewController *questionsController = segue.destinationViewController;
    
    UIButton *button = (UIButton *)sender;
    
    if (button.tag == 1)
    {
        _data.didStudyMissed = NO;
        _data.currentNumber = 0;
        _data.questions = [self getQuestions:_label.title];
        [self initalizeArray];
    }
    /*else if (button.tag == 2)
    {
        _data.didStudyMissed = YES;
        _data.currentNumber = 0;
        [self studyMissed];
    }*/
    else
    {
        questionsController.goToQuestion = [self firstUnanswered];
    }
    
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //hasStarted = YES;
    //[userDefaults setBool:hasStarted forKey:[NSString stringWithFormat:@"%@started", _label.title]];
    //[userDefaults setObject:_data.questions forKey:[NSString stringWithFormat:@"%@questions", _label.title]];
    
    questionsController.data = _data;
    questionsController.parentController = self;
}

- (NSArray *) getQuestions:(NSString *)fileName
{
    NSURL *path = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"csv"];
    NSString* fileContents = [NSString stringWithContentsOfURL:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
    NSMutableArray *array;
    array = [NSMutableArray arrayWithCapacity:rows.count];
    for (int i = 0; i < rows.count; i++)
    {
        NSString* row = [rows objectAtIndex:i];
        [array insertObject:[row componentsSeparatedByString:@"|"] atIndex:i];
    }
    
    //NSLog(@"array: %@", array);
    
    return array;
}

- (void) preserveState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *answersInfo = [_data preserveState];
    //NSLog(@"answersInfo:%@", answersInfo);
    [userDefaults setObject:answersInfo forKey:_label.title];
    //[userDefaults setBool:_data.didStudyMissed forKey:[NSString stringWithFormat:@"%@missed", _label.title]];
}

- (void) restoreState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *restoreInfo = [userDefaults dictionaryForKey:_label.title];
    //_data.questions = [userDefaults objectForKey:[NSString stringWithFormat:@"%@questions", _label.title]];
    //_data.didStudyMissed = [userDefaults boolForKey:[NSString stringWithFormat:@"%@missed", _label.title]];
    //NSLog(@"restoreInfo:%@", restoreInfo);
    [_data restoreState:restoreInfo];
}

- (int)numberOfAnswered
{
    int answered = 0;
    TPAnswer *object;
    
    if (_data.qsAnswered.count == 0)
    {
        return 0;
    }
    
    for (int i = 0; i < _data.qsAnswered.count; i++)
    {
        object = (TPAnswer *)[_data.qsAnswered objectAtIndex:i];
        if (object.answered)
        {
            answered++;
        }
    }
    
    return answered;
}

- (int)rightAnswers
{
    int answered = 0;
    TPAnswer *object;
    
    if (_data.qsAnswered.count == 0)
    {
        return 0;
    }
    
    for (int i = 0; i < _data.qsAnswered.count; i++)
    {
        object = (TPAnswer *)[_data.qsAnswered objectAtIndex:i];
        if (object.correct)
        {
            answered++;
        }
    }
    
    return answered;
}

- (int) wrongAnswers
{
    int answered = 0;
    TPAnswer *object;
    
    if (_data.qsAnswered.count == 0)
    {
        return 0;
    }
    
    for (int i = 0; i < _data.qsAnswered.count; i++)
    {
        object = (TPAnswer *)[_data.qsAnswered objectAtIndex:i];
        if (object.answered && !object.correct)
        {
            answered++;
        }
    }
    
    return answered;
}

- (int)firstUnanswered
{
    int index = 1;
    
    TPAnswer *object;
    
    if (_data.qsAnswered.count == 0)
    {
        return 1;
    }
    
    for (int i = 0; i < _data.qsAnswered.count; i++)
    {
        object = (TPAnswer *)[_data.qsAnswered objectAtIndex:i];
        if (!object.answered)
        {
            index = i;
            break;
        }
    }

    
    return index;
}

- (void)initalizeArray
{
    _array = [[NSMutableArray alloc] initWithCapacity:_data.questions.count];
    
    for (int i = 0; i < _data.questions.count; i++)
    {
        TPAnswer *object = [[TPAnswer alloc] initWithAnswer:@"" answered:NO correct:NO];
        [_array insertObject:object atIndex:i];
    }
    
    //NSLog(@"%@", _array);
    
    _data.qsAnswered = _array;
}

- (void) studyMissed
{
     //initialize questions
    [self getMissed];
    
    //initialize qsAnswered array
    _array = [[NSMutableArray alloc] initWithCapacity:[self wrongAnswers]];
    
    for (int i = 0; i < [self wrongAnswers]; i++)
    {
        TPAnswer *object = [[TPAnswer alloc] initWithAnswer:@"" answered:NO correct:NO];
        [_array insertObject:object atIndex:i];
    }
    
    //NSLog(@"%@", _array);
    _data.qsAnswered = _array;
}

- (void)getMissed
{
    int index = 0;
    TPAnswer *object;
    NSMutableArray *questionsArray = [[NSMutableArray alloc] initWithCapacity:[self wrongAnswers]];
    
    for (int i = 0; i < _data.qsAnswered.count; i++)
    {
        object = (TPAnswer *)[_data.qsAnswered objectAtIndex:i];
        if (object.answered && !object.correct)
        {
            [questionsArray insertObject:_data.questions[i] atIndex:index];
            index++;
        }
    }
    
    _data.questions = (NSArray *)questionsArray;
}

- (void) updateSliceData
{
    for(int i = 0; i < 3; i ++)
    {
        if (i==0)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[self rightAnswers]]]; //right
        }
        else if (i==1)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:((int)_data.questions.count - [self numberOfAnswered])]]; // unanswered
        }
        else if (i==2)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[self wrongAnswers]]]; //wrong
        }
        //[self.pieChart reloadData];
    }
}

- (void) resetSlices
{
    for(int i = 0; i < 3; i ++)
    {
        if (i==0)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];//[self rightAnswers]]]; //right
        }
        else if (i==1)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];//((int)_data.questions.count - [self numberOfAnswered])]]; // unanswered
        }
        else if (i==2)
        {
            [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];//[self wrongAnswers]]]; //wrong
        }
    }
    [_pieChart reloadData];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %lu",(unsigned long)index);
    _questionsLabel.text = [NSString stringWithFormat:@"Questions Right: %@ of %i",[self.slices objectAtIndex:index], (int)_data.questions.count];
}
    
@end
