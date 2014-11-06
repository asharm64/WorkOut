//
//  WeekListViewController.h
//  WorkOut
//
//  Created by nyalama1 on 10/28/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface WeekListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *weekList;

@property (nonatomic, strong) NSMutableArray* week;

@property NSDictionary *weekDays;
@property NSDictionary *weekDaysNotes;

@end
