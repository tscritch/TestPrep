//
//  TPDataModel.m
//  TestPrep
//
//  Created by Tad Scritchfield on 4/25/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPDataModel.h"
#import "TPAnswer.h"

@implementation TPDataModel

- (id) initWithQuestions:(NSArray *)array1 answers:(NSMutableArray *)array2 number:(int)number studyMissed:(BOOL)studyMissed
{
    self = [super init];
    if (self) {
        self.questions = array1;
        self.qsAnswered = array2;
        self.currentNumber = number;
        self.didStudyMissed = studyMissed;
    }
    return self;
}

- (NSDictionary *) preserveState
{
    NSMutableDictionary *theDictionary = [[NSMutableDictionary alloc] init];
    TPAnswer *anAnswer;
    NSLog(@"preserving data");
    for (int i = 0; i < _questions.count; i++)
    {
        anAnswer = _qsAnswered[i];
        //NSLog(@"anAnswer:%@", anAnswer);
        NSDictionary *aDictionary = [anAnswer preserveState];
        //NSLog(@"aDictionary:%@", aDictionary);
        [theDictionary setObject:aDictionary forKey:[NSString stringWithFormat:@"anAnswer%i", i]];
        
    }
    //NSLog(@"theDictionary:%@", theDictionary);
    return theDictionary;
}

- (void) restoreState:(NSDictionary *)state
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:_questions.count];
    
    NSLog(@"restoring data");
    for (int i = 0; i < _questions.count; i++)
    {
        TPAnswer *anAnswer = [[TPAnswer alloc] initWithAnswer:@"" answered:NO correct:NO];
        [anAnswer restoreState:state index:i];
        [array insertObject:anAnswer atIndex:i];
    }
    
    //NSLog(@"qsArray:%@", array);
    _qsAnswered = array;
}

@end
