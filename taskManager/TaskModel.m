//
//  TaskModel.m
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel
@synthesize TM_createdDate,TM_description,TM_dueDate,TM_image,TM_modifiedDate,TM_name,TM_taskID;

+ (void)saveTaskWithName:(NSString *)name withDescription:(NSString *)description withDueDate:(NSDate *)dueDate {
    
    PFObject *taskData = [PFObject objectWithClassName:@"taskList"];
    taskData[@"name"] = name;
    taskData[@"description"] = description;
    taskData[@"dueDate"] = dueDate;
    
    [taskData saveEventually:^(BOOL succeeded, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }else{
            NSLog(@"Data saved successfully.");
        }
    }];
}

@end
