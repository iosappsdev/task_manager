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

@interface TaskMainVC ()
- (IBAction)newTask:(id)sender;
- (IBAction)options:(id)sender;
@end

@implementation TaskMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Task Manager";
}

- (void)viewWillAppear:(BOOL)animated {
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
        self.objectsPerPage = 10;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    /*    if ([self.objects count] == 0) {
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }*/
    
    //    [query orderByAscending:@"name"];
    
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
    //PFFile *thumbnail = [object objectForKey:@"imageFile"];
    //PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
    
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    //NSLog(@"error: %@", [error localizedDescription]);
}

- (IBAction)newTask:(id)sender {
    
    CreateTaskVC *createVC =[self.storyboard instantiateViewControllerWithIdentifier:@"CreateTaskVC"];
    createVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (IBAction)options:(id)sender {
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {

     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     PFObject *object = [self.objects objectAtIndex:indexPath.row];
     NSString *objectID = [object objectId];
     NSLog(@"Selected Object ID: %@", objectID);
     
     TaskModel *dataModel = [[TaskModel alloc]init];
     dataModel.TM_name = [object objectForKey:@"name"];
     dataModel.TM_description = [object objectForKey:@"description"];
     dataModel.TM_dueDate = [object objectForKey:@"dueDate"];
     
     NSLog(@"%@",dataModel.TM_dueDate);
     dataModel.TM_taskID = objectID;
     
     static NSString *segueID = @"detailView";
     
     if ([segue.identifier isEqualToString:segueID]) {
         
         EditTaskVC *editVC = [segue destinationViewController];
         editVC.dataModel = dataModel;
     }
 }

@end
