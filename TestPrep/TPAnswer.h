//
//  TPAnswer.h
//  TestPrep
//
//  Created by Tad Scritchfield on 4/25/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPAnswer : NSObject

@property (strong, nonatomic) NSString *userAnswer;
@property (nonatomic) BOOL answered;
@property (nonatomic) BOOL correct;

- (id) initWithAnswer:(NSString *)string answered:(BOOL)answered correct:(BOOL)correct;

- (NSDictionary *) preserveState;
- (void) restoreState:(NSDictionary *)state index:(int)index;

@end
