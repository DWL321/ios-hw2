//
//  ProfileController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import "ProfileController.h"
#import "SubViewControllers/LoginViewController.h"
#import "SubViewControllers/ProfileViewController.h"

@interface ProfileController()

@property (nonatomic, strong) LoginViewController* loginView;
@property (nonatomic, strong) ProfileViewController* profileView;

@end

@implementation ProfileController

- (void)login:(NSString *)userName withEmail:(NSString *)email withPhone:(NSString *)phone withAvatar:(UIImage *)avatar{
    [self pushViewController:[self profileView] animated:true];
    [[self profileView] setUser:userName withEmail:email withPhone:phone withAvatar:avatar];
}

- (LoginViewController *)loginView {
    if (_loginView == nil) {
        _loginView = [[LoginViewController alloc] init];
        [_loginView setDelegate:self];
    }
    return _loginView;
}

- (ProfileViewController *)profileView {
    if (_profileView == nil) {
        _profileView = [[ProfileViewController alloc] init];
        [self setLoginDelegate:_profileView];
    }
    return _profileView;
}

- (instancetype)init{
    self = [super init];
    [self.tabBarItem setTitle:@"我的"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"profile.png"]];
    [self addChildViewController:[self loginView]];
    return self;
}

@end
