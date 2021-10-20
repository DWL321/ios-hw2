//
//  CheckinController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import "CheckinController.h"
#import "../AppDelegate.h"
#import "../Models/CheckinModel.h"
#import "SubViewControllers/CheckinEditViewComtroller.h"

@interface CheckinController() {
    CheckinEditViewController *editController;
}

@end

@implementation CheckinController

- (instancetype)init {
    self = [super init];
    self.tabBarItem.title = @"记录";
    [self.tabBarItem setImage:[UIImage imageNamed:@"checkin.png"]];
    editController = [[CheckinEditViewController alloc] init];
    [self addChildViewController:editController];
    return self;
}

@end
