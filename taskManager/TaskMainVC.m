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

@interface TaskMainVC () {
    // Count Number of Objects Loaded
    // **Testing ONLY**
    int objectCounter;
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
    
    // Init Counter
    objectCounter = 0;
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
    //PFFile *thumbnail = [object objectForKey:@"imageFile"];
    //PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
    
    return cell;
}

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        NSLog(@"It's all good!");
    }
    
}

- (PFObject *)getObject {
    
    // Get Selected Row
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // Create Object from Objects Array
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    // Output Object ID
    NSLog(@"Object ID: %@", [object objectId]);
    
    // Return Selected Object
    return object;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {

     TaskModel *dataModel = [[TaskModel alloc]init];
     dataModel.TM_name = [[self getObject] objectForKey:@"name"];
     dataModel.TM_description = [[self getObject] objectForKey:@"description"];
     dataModel.TM_dueDate = [[self getObject] objectForKey:@"dueDate"];
     dataModel.TM_taskID = [self getObject].objectId;
     
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

@end
