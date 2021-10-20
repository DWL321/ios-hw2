//
//  DiscoverController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import "DiscoverController.h"
#import "SubViewControllers/DiscoverListViewController.h"

@interface DiscoverController() {
    DiscoverListViewController* listView;
}

@end

@implementation DiscoverController

- (instancetype)init{
    self = [super init];
    self.tabBarItem.title = @"发现";
    [self.tabBarItem setImage:[UIImage imageNamed:@"discover.png"]];
    listView = [[DiscoverListViewController alloc] init];
    [self addChildViewController:listView];
    return self;
}

@end
