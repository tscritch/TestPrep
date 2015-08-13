//
//  TPDataModel.h
//  TestPrep
//
//  Created by Tad Scritchfield on 4/25/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDataModel : NSObject

@property (nonatomic) BOOL didStudyMissed;
@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) NSMutableArray *qsAnswered;
@property (nonatomic) int currentNumber;

- (id) initWithQuestions:(NSArray *)array1 answers:(NSMutableArray *)array2 number:(int)number studyMissed:(BOOL)studyMissed;

- (NSDictionary *) preserveState;
- (void) restoreState:(NSDictionary *)state;

@end
