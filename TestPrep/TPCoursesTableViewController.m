//
//  TPCoursesTableViewController.m
//  TestPrep
//
//  Created by Tad Scritchfield on 4/23/14.
//  Copyright (c) 2014 Tad Scritchfield. All rights reserved.
//

#import "TPCoursesTableViewController.h"
#import "TPOverviewViewController.h"
#import "TPTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TPCoursesTableViewController ()

@property (assign, nonatomic) CATransform3D initialTransformation;

@end

@implementation TPCoursesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Samba" size:22], NSFontAttributeName,
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                     nil];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setOpaque:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    
    _list = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TestList" ofType:@"plist"]];
    
    CGFloat rotationAngleDegrees = 90;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    //CGPoint offsetPositioning = CGPointMake(0, -90);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, -550.0, 0.0, 0.0);
    transform = CATransform3DTranslate(transform, 0.0, 0.0, -90);
    _initialTransformation = transform;
    
    
    
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *CellId = @"Cell";
    TPTableViewCell *cell = (TPTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    
    [cell initWithName:[_list objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TPOverviewViewController *overViewController = segue.destinationViewController;
    TPTableViewCell *textCell = (TPTableViewCell *)sender;
    overViewController.label.title = textCell.label.text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


/*- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *card = [(TPTableViewCell* )cell mainView];
    
    card.layer.transform = self.initialTransformation;
    card.layer.opacity = 0.8;
    //card.layer.position = CGPointMake(160, -100);
    
    [UIView animateWithDuration:2 animations:^{
        card.layer.transform = CATransform3DIdentity;
        card.layer.opacity = 1;
        //card.layer.position = CGPointMake(160, 100);
    }];
}*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
