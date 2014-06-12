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
- (IBAction)saveTask:(id)sender;
@end

@implementation CreateTaskVC
@synthesize tf_description,tf_taskName;

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
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"User Cancelled Selection");
}

// IBActions
- (IBAction)saveTask:(id)sender {
    [TaskModel saveTaskWithName:tf_taskName.text withDescription:tf_description.text withDueDate:localDueDate];
}
@end
