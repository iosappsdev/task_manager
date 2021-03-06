//
//  EditTaskVC.h
//  taskManager
//
//  Created by Ricardo Ruiz on 6/11/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
#import "RMDateSelectionViewController.h"

@interface EditTaskVC : UIViewController<RMDateSelectionViewControllerDelegate, UIActionSheetDelegate>
@property (nonatomic,strong) TaskModel *dataModel;
@end
