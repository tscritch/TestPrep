//
//  TPAnswer.m
//  TestPrep
//
//  Created by Tad Scritchfield on 4/25/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPAnswer.h"

@implementation TPAnswer

- (id) initWithAnswer:(NSString *)string answered:(BOOL)answered correct:(BOOL)correct
{
    self = [super init];
    if (self) {
        self.userAnswer = string;
        self.answered = answered;
        self.correct = correct;
    }
    return self;
}

- (NSDictionary *) preserveState
{
    return @{@"userAnswer": _userAnswer,
             @"answered": @(_answered),
             @"correct": @(_correct)};
}

- (void) restoreState:(NSDictionary *)state index:(int)index
{
    NSDictionary *aDictionary = state[[NSString stringWithFormat:@"anAnswer%i", index]];
    //NSLog(@"%@", aDictionary);
    _userAnswer = aDictionary[@"userAnswer"];
    _answered = [aDictionary[@"answered"] boolValue];
    _correct = [aDictionary[@"correct"] boolValue];
}

@end
