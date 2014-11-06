//
//  AddItemViewController.h
//  WorkOut
//
//  Created by asharm64 on 10/27/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WorkoutlistItem.h"
@class AddItemViewController;
@protocol AddItemViewControllerDelegate <NSObject>

-(void) addItemViewControllerDidCancel : (AddItemViewController *) controller;
-(void) addItemViewController:(AddItemViewController *)controller didFinishAddingItem : (WorkoutlistItem *)item;

@end

@interface AddItemViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *workoutText;
@property (nonatomic,weak) id<AddItemViewControllerDelegate> delegate;

@end
