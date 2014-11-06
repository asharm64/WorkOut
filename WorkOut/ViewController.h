//
//  ViewController.h
//  WorkOut
//
//  Created by nyalama1 on 10/24/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutlistItem.h"
#import "AddItemViewController.h"
#import "WeekListViewController.h"



@interface ViewController : UITableViewController <AddItemViewControllerDelegate>

@property NSMutableArray *items;
@property NSMutableArray *notes;

- (IBAction)addItem:(id)sender;


@end

