//
//  ProfileController.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubViewControllers/LoginViewController.h"

@protocol UserChangeNotify <NSObject>

@required
- (void)setUser:(NSString*)userName withEmail:(NSString*)email withPhone:(NSString*)phone withAvatar:(UIImage*)avatar;

@end

@interface ProfileController : UINavigationController<LoginNotify>
@property (nonatomic, weak) id<UserChangeNotify> loginDelegate;
@end
