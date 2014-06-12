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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStylePlain target:self action:nil];
    
    // Edit Button (Right)
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoEdit)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)goBackInStack {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Case 0");
            break;
        case 1:
            NSLog(@"Case 1");
            break;
        case 2:
            NSLog(@"Case 2");
            break;
            
        default:
            break;
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    NSLog(@"User Called Selection From ActionSheet");
}

@end
