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
- (void)gotoEdit;
@end

@implementation EditTaskVC
@synthesize dataModel, tv_description, lb_dueDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = dataModel.TM_name;
    tv_description.text = dataModel.TM_description;
    
    // Clear Back Button Title
    // self.navigationController.navigationItem.leftBarButtonItem.title = @"";
    [self.navigationController.navigationItem.leftBarButtonItem
    
    
    // Edit Button
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoEdit)];
    
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)gotoEdit {
    NSLog(@"Edit Button Selected");
    
    UIActionSheet *options = [[UIActionSheet alloc]initWithTitle:@"Task Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [options showInView:self.view];
}

- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    NSLog(@"User Called Selection From ActionSheet");
}

@end
