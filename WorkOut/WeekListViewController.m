//
//  WeekListViewController.m
//  WorkOut
//
//  Created by nyalama1 on 10/28/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "WeekListViewController.h"

@interface WeekListViewController ()


@end

@implementation WeekListViewController

NSMutableArray *selectedDayItems;
NSMutableArray * selectedDayNotes;

-(id)init
{
    self=[super init];
    
    return self;
    
}

- (void)viewDidLoad
{
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
    [super viewDidLoad];
    [self loadWorkoutlistItems];
    
    self.week = [NSMutableArray arrayWithObjects:                  @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday", Nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.week count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"weekCell";
    
    UITableViewCell *cell = [self.weekList
                             dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.week
                           objectAtIndex:indexPath.row]; 
    
    return cell; 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString* selectedWeek= [self.week objectAtIndex:indexPath.row];
    
    selectedDayItems = [_weekDays objectForKey:selectedWeek];
    
    selectedDayNotes= [_weekDaysNotes objectForKey:selectedWeek];
    
    [self performSegueWithIdentifier:@"toWorkoutList" sender:self];
}


- ( void ) prepareForSegue :( UIStoryboardSegue *) segue sender :( id) sender {
    if ([ segue.identifier isEqualToString : @"toWorkoutList"])
    {
        ViewController *dest= (ViewController *)segue.destinationViewController;
        dest.items = selectedDayItems;
        dest.notes=selectedDayNotes; 
    }
}

- ( NSString *) documentsDirectory
{
    
    //  path to <our applications home >/ Documents
    return [@"~/Documents" stringByExpandingTildeInPath];
}

- ( NSString *) dataFilePath
{
    return [[self documentsDirectory]stringByAppendingPathComponent :@"Workoutlist2.plist"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveWorkoutlistItems];
}

- (void) saveWorkoutlistItems
{
    // create a generic data storage object
    NSMutableData * data = [[ NSMutableData alloc ] init ];
    // tell the archiver to use the storage we jut allocated , the archiverwill do the
    // encoding steps and then write the result into that data object
    NSKeyedArchiver * archiver = [[ NSKeyedArchiver alloc ]
                                  initForWritingWithMutableData : data ];
    // encode items array and just with all dictionaries we need a key
    
    [archiver encodeObject :_weekDays forKey :@"Workoutlist"];
    [archiver encodeObject :_weekDaysNotes forKey :@"WorkoutlistNotes"];
    
    [ archiver finishEncoding ];
    [ data writeToFile :[ self dataFilePath ] atomically : YES ];
}

- (void) loadWorkoutlistItems
{
    // get our data file path
    NSString * path = [self dataFilePath];
    // do we have anything in our documents directory ? If we have anythingthen load it up
    if ([[ NSFileManager defaultManager ] fileExistsAtPath : path ]) {
        // same way , except this time since we aren ’t adding anything toour data
        // we don ’t need mutable data , just what we are loading
        NSData * data = [[ NSData alloc ] initWithContentsOfFile : path ];
        // make an unarchiver , and point it to our data
        NSKeyedUnarchiver * unarchiver = [[ NSKeyedUnarchiver alloc ]
                                          initForReadingWithData : data ];
        // We would like to unarchive the " workOutlistItems " key and get areference to it
        _weekDays  = [ unarchiver decodeObjectForKey : @"Workoutlist"];
        
        _weekDaysNotes  = [ unarchiver decodeObjectForKey : @"WorkoutlistNotes"];
        
        // we ’ve finished choosing keys that we want , unpack them !
        [ unarchiver finishDecoding ];
    }
    
    if(!_weekDays)
        _weekDays= [[NSDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc]init],@"Monday",[[NSMutableArray alloc]init],@"Tuesday",[[NSMutableArray alloc]init],@"Wednesday",[[NSMutableArray alloc]init],@"Thursday",[[NSMutableArray alloc]init],@"Friday",[[NSMutableArray alloc]init],@"Saturday",[[NSMutableArray alloc]init],@"Sunday", nil];
    if(!_weekDaysNotes)
        _weekDaysNotes=[[NSDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc]init],@"Monday",[[NSMutableArray alloc]init],@"Tuesday",[[NSMutableArray alloc]init],@"Wednesday",[[NSMutableArray alloc]init],@"Thursday",[[NSMutableArray alloc]init],@"Friday",[[NSMutableArray alloc]init],@"Saturday",[[NSMutableArray alloc]init],@"Sunday", nil];
}



@end
