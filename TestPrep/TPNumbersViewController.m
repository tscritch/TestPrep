//
//  TPNumbersViewController.m
//  TestPrep
//
//  Created by Tad Scritchfield on 6/5/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPNumbersViewController.h"

@interface TPNumbersViewController ()

@end

@implementation TPNumbersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    //self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    //self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGRect newBounds = CGRectMake(bounds.origin.x, bounds.origin.y + 74, bounds.size.width, bounds.size.height + 74);
    
    self.tableView.frame = newBounds;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _numberOfQuestions;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"numberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row+1];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _parentController.goToQuestion = (int)indexPath.row;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
