//
//  ViewController.m
//  WorkOut
//
//  Created by nyalama1 on 10/24/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@end

@implementation ViewController

//NSMutableArray *items;


- (void)viewDidLoad {
    
    [ super viewDidLoad ];
  //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *todaysDate = [NSDate date];
//    
//    NSLog(@"%@: %@",[formatter stringFromDate:todaysDate], self.notesTextView.text);

    if(_notes.count>0)
     _notesTextView.text=[_notes objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( NSInteger ) numberOfSectionsInTableView :( UITableView *) tableView
{
    // we only have a single section
    return 1;
}

- ( NSInteger ) tableView :( UITableView *) tableView numberOfRowsInSection :(NSInteger ) section
{
    // section has a single row
    return [ _items count ];

}

//sections headings
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if(section == 0)
//        return @"Workouts";
//    else
//        return @"Notes";
//}


- ( UITableViewCell *) tableView :( UITableView *) tableView
           cellForRowAtIndexPath :( NSIndexPath *) indexPath
{
    // we only have 1 cell type so we know which prototype to use
    // if you named our identifier differently make sure it matches !!
    // if the system can ’t find the prototype cell it will crash !
    UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier : @"Workoutlist"];
    
    WorkoutlistItem * item = [ _items objectAtIndex : indexPath . row ];
    UILabel * label=(UILabel *) [cell viewWithTag :3];
    label.text = item.text;
    if(item.checked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell ;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  WorkoutlistItem * item = [_items objectAtIndex:indexPath.row];
    [item toggleChecked];
    if(cell.accessoryType ==UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // [self saveWorkoutlistItems];
}

- (IBAction) addItem :(id) sender {
    int newRowIndex = (int)[_items count];
    WorkoutlistItem *item= [[WorkoutlistItem alloc] init];
    item.text = [NSString stringWithFormat:@"I'm new, and number %d", newRowIndex];
    item.checked = NO;
    [self.tableView reloadData];
  
    
    
}

- ( void ) tableView :( UITableView *) tableView commitEditingStyle :(UITableViewCellEditingStyle ) editingStyle forRowAtIndexPath :(NSIndexPath *) indexPath
{
    // remove the cell
    [ _items removeObjectAtIndex : indexPath.row ];
    
    [ tableView reloadData ];
}

- ( void ) addItemViewController :( AddItemViewController *) controller
             didFinishAddingItem :( WorkoutlistItem *) item
{
    int newRowIndex = (int)[ _items count ];
    [ _items addObject : item ];
    NSIndexPath * indexPath = [ NSIndexPath indexPathForRow : newRowIndex                                          inSection :0];
    
    NSArray * indexPaths = [ NSArray arrayWithObject : indexPath ];
   
    // this simply tells the table that one new element has appeared
    // if it is in the view then changes are animated ( possibly )
    // if the object is our of view then the table doesn ’t change visually
    [self.tableView insertRowsAtIndexPaths :indexPaths withRowAnimation :UITableViewRowAnimationAutomatic];
    
    // dismiss our modal view we are done with it
    [self dismissViewControllerAnimated : YES completion : nil ];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //saving notes here
    [_notes setObject:_notesTextView.text atIndexedSubscript:0];
}

// this method is defined by protocol
- ( void ) addItemViewControllerDidCancel :( AddItemViewController *) controller
{
    // dismiss our modal view , we are done with it
    [ self dismissViewControllerAnimated : YES completion : nil ];
}

//method for segue to go to destination view controller
- ( void ) prepareForSegue :( UIStoryboardSegue *) segue sender :( id) sender {
    if ([ segue.identifier isEqualToString : @"AddItem"])
    {
        // we are handing off control to another navigation controller , get a reference to it
        UINavigationController * navigationController = segue .destinationViewController ;
        // in that navigation controller the first view shown will be our AddItemViewController
        // get a reference to that controller
        AddItemViewController * controller = ( AddItemViewController *) navigationController.topViewController ;
        // set ourselves as its delegate
        controller . delegate = self ;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
