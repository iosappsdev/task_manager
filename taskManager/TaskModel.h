//
//  TaskModel.h
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TaskModel : NSObject

@property (nonatomic,strong) NSString *TM_taskID;
@property (nonatomic,strong) NSString *TM_name;
@property (nonatomic,strong) NSString *TM_description;
@property (nonatomic,strong) NSDate *TM_dueDate;
@property (nonatomic,strong) NSDate *TM_createdDate;
@property (nonatomic,strong) NSDate *TM_modifiedDate;

@property (nonatomic,strong) PFFile *TM_image;

+(void)saveTaskWithName:(NSString *)name withDescription:(NSString *)description withDueDate:(NSDate *)dueDate;

@end
