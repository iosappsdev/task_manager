//
//  CreateTaskVC.m
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "CreateTaskVC.h"

@interface CreateTaskVC ()
@property (strong, nonatomic) IBOutlet UITextField *tf_taskName;
@property (strong, nonatomic) IBOutlet UITextField *tf_description;
@property (strong, nonatomic) IBOutlet UIDatePicker *dp_dueDate;
- (IBAction)saveTask:(id)sender;
@end

@implementation CreateTaskVC
@synthesize tf_description,tf_taskName, dp_dueDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set View Title
    self.title = @"Create Task";
    
    // Clear Back Button Title
    self.navigationController.navigationBar.topItem.title = @"";
}

- (IBAction)saveTask:(id)sender {
    [TaskModel saveTaskWithName:tf_taskName.text withDescription:tf_description.text withDueDate:dp_dueDate.date];
}
@end
