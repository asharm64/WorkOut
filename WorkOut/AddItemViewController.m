//
//  AddItemViewController.m
//  WorkOut
//
//  Created by asharm64 on 10/27/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "AddItemViewController.h"

@implementation AddItemViewController
@synthesize workoutText;

- (void)viewDidLoad {
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
}


- (IBAction)Cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
    //[ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}

- (IBAction)Save:(id)sender {
    WorkoutlistItem *item =[[WorkoutlistItem alloc] init];
    item.text = self.workoutText.text;
    item.checked =NO;
    [self.delegate addItemViewController:self didFinishAddingItem : item];
    //[ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}


-(NSIndexPath *) tableView:(UITableView *) tableView willSelectRowAtIndexPath :(NSIndexPath *)indexPath
{
    return nil;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.workoutText becomeFirstResponder];
}
@end
