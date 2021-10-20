//
//  LoginViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import "../ProfileController.h"
#import "ProfileViewController.h"

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"我的"];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)handleTouch:(UIButton *)button {
    [self.delegate login:@"DWL" withEmail:@"1234567890@qq.com" withPhone:@"12345678910" withAvatar:[UIImage imageNamed:@"user.jpeg"]];
}

- (UIImage *)gradientColorImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(imgSize.width / 2, imgSize.height / 2), 0, CGPointMake(imgSize.width / 2, imgSize.height / 2), 360, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 - 100, 200, 200);
    
    btn.layer.cornerRadius = 100;
    btn.layer.borderWidth = 1.0;
    
    btn.layer.borderColor = UIColor.grayColor.CGColor;
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setBackgroundColor:UIColor.clearColor];
    [btn setFont:[UIFont systemFontOfSize:25]];
    
    [btn addTarget:self action:@selector(handleTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIColor *centerColor = [UIColor colorWithRed:135/255.0f green:206/255.0f blue:235/255.0f alpha:1.0f];
    UIColor *outsideColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:190/255.0f alpha:1.0f];
    UIImage *bgImg = [self gradientColorImageFromColors:@[centerColor, outsideColor] imgSize:self.view.bounds.size];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
}

@end
