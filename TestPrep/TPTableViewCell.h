//
//  TPTableViewCell.h
//  TestPrep
//
//  Created by Tad Scritchfield on 5/20/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *blurView;

- (void) initWithName:(NSString *)name;

@end
