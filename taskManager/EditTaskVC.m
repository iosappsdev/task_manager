//
//  EditTaskVC.m
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "EditTaskVC.h"

@interface EditTaskVC ()
@property (strong, nonatomic) IBOutlet UITextView *tv_description;
@property (strong, nonatomic) IBOutlet UILabel *lb_dueDate;
@end

@implementation EditTaskVC
@synthesize dataModel, tv_description, lb_dueDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = dataModel.TM_name;
    tv_description.text = dataModel.TM_description;
}

@end
