//
//  TPTableViewCell.m
//  TestPrep
//
//  Created by Tad Scritchfield on 5/20/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPTableViewCell.h"

@implementation TPTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) initWithName:(NSString *)name
{
    //CGRect frame = CGRectMake(0, 0, 320, 132);
    UIImage *image = [UIImage imageNamed:name];
    //[image drawInRect:frame];
    _image.image = image;
    
    _label.font = [UIFont fontWithName:@"Samba" size:24];
    _label.text = name;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurBackgroundView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurBackgroundView.frame = _blurView.bounds;
    [_blurView addSubview:blurBackgroundView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
