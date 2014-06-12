//
//  CreateTaskVC.m
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "CreateTaskVC.h"

@interface CreateTaskVC () {
    NSDate *localDueDate;
}
@property (strong, nonatomic) IBOutlet UITextField *tf_taskName;
@property (strong, nonatomic) IBOutlet UITextField *tf_description;
@property (weak, nonatomic) IBOutlet UILabel *lb_dueDate;
- (IBAction)saveTask:(id)sender;
- (IBAction)selectDueDate:(id)sender;
@end

@implementation CreateTaskVC
@synthesize tf_description,tf_taskName,lb_dueDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set View Title
    self.title = @"Create Task";
    
    // Clear Back Button Title
    // self.navigationController.navigationBar.topItem.title = @"";
}

// Delegate Methods
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    localDueDate = aDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    lb_dueDate.text = [formatter stringFromDate:localDueDate];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"User Cancelled Selection");
}

// IBActions
- (IBAction)saveTask:(id)sender {
    
    if (tf_taskName.text == 0 || tf_description.text == 0 || localDueDate == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Task Manager" message:@"Please set a Task Name, Description and Due Date" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [alert show];
    } else {
        [TaskModel saveTaskWithName:tf_taskName.text withDescription:tf_description.text withDueDate:localDueDate];
    }
}

- (IBAction)selectDueDate:(id)sender {
    
    RMDateSelectionViewController *datePicker = [[RMDateSelectionViewController alloc]init];
    [datePicker show];
}
@end
