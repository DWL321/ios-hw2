//
//  ViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import "ViewController.h"
#import "Controllers/DiscoverController.h"
#import "Controllers/CheckinController.h"
#import "Controllers/ProfileController.h"

@interface ViewController ()

@property (nonatomic, strong) DiscoverController* discovery;
@property (nonatomic, strong) CheckinController* checkin;
@property (nonatomic, strong) ProfileController* profile;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[self discovery]];
    [self addChildViewController:[self checkin]];
    [self addChildViewController:[self profile]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self.navigationItem setTitle:item.title];
}

- (DiscoverController *)discovery{
    if (_discovery == nil) {
        _discovery = [[DiscoverController alloc] init];
    }
    return _discovery;
}

- (CheckinController *)checkin{
    if (_checkin == nil) {
        _checkin = [[CheckinController alloc] init];
    }
    return _checkin;
}

- (ProfileController *)profile{
    if (_profile == nil) {
        _profile = [[ProfileController alloc] init];
    }
    return _profile;
}

@end
