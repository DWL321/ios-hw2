//
//  LoginViewController.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginNotify <NSObject>

@required
- (void)login:(NSString*)userName withEmail:(NSString*)email withPhone:(NSString*)phone withAvatar:(UIImage*)avatar;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id<LoginNotify> delegate;

@end
