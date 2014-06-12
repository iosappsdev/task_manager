//
//  TaskMainVC.m
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "TaskMainVC.h"
#import "CreateTaskVC.h"
#import "EditTaskVC.h"

@interface TaskMainVC ()<UIAlertViewDelegate> {
    
    // NSIndexPath used for Row Deletion
    NSIndexPath *selectedPath;
}
- (IBAction)newTask:(id)sender;
- (IBAction)options:(id)sender;
@end

@implementation TaskMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set Title
    self.title = @"Task Manager";
}

- (void)viewWillAppear:(BOOL)animated {
    // Reload Objects to Check For Changes
    [self loadObjects];
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"taskList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 20;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
   if ([self.objects count] == 0) {
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }
    
    [query orderByAscending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    // Configure the cell
    // PFFile *thumbnail = [object objectForKey:@"imageFile"];
    // PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    // thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    // thumbnailImageView.file = thumbnail;
    // [thumbnailImageView loadInBackground];
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:@"news.png"];
    
    return cell;
}

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];

    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        NSLog(@"It's all good! Your Objects are loaded!");
    }
}

- (PFObject *)getObject {
    
    // Get Selected Row
    selectedPath = [self.tableView indexPathForSelectedRow];
    // Create Object from Objects Array
    PFObject *object = [self.objects objectAtIndex:selectedPath.row];
    
    // Return Selected Object
    return object;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     // Output Object ID
     NSLog(@"You Selected Object ID: %@", [[self getObject] objectId]);
     
     // Load Model Data
     TaskModel *dataModel = [[TaskModel alloc]init];
     dataModel.TM_name = [[self getObject] objectForKey:@"name"];
     dataModel.TM_description = [[self getObject] objectForKey:@"description"];
     dataModel.TM_dueDate = [[self getObject] objectForKey:@"dueDate"];
     //dataModel.TM_taskID = [self getObject].objectId;
     
     static NSString *segueID = @"detailView";
     
     if ([segue.identifier isEqualToString:segueID]) {
         
         EditTaskVC *editVC = [segue destinationViewController];
         editVC.dataModel = dataModel;
     }
 }

- (IBAction)newTask:(id)sender {
    
    CreateTaskVC *createVC =[self.storyboard instantiateViewControllerWithIdentifier:@"CreateTaskVC"];
    createVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (IBAction)options:(id)sender {
}

#pragma mark - TableView Edit/Delete

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //selectedPath = indexPath;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete Task" message:@"Are you sure you want to delete this Task?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [alert show];
        
    }
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"User Canceled");
            break;
        case 1: {
            // Log out Object ID
            NSLog(@"Object %@ was Deleted.", [self getObject].objectId);
            
            // Delete Object
            PFObject *object = [self.objects objectAtIndex:selectedPath.row];
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self loadObjects];
            }];
        }
            break;
            
        default:
            break;
    }
}
@end
