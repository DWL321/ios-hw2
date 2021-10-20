//
//  ProfileViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"

@interface ProfileViewController()

@property (nonatomic, strong)UIImageView* avatarView;
@property (nonatomic, strong)UITextView* infoView;
@property (nonatomic, strong)UITableView* menuTable;

@end

@implementation ProfileViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
            [cell setText:@"版本"];
            break;
        case 1:
            [cell setText:@"隐私和 Cookies"];
            break;
        case 2:
            [cell setText:@"清除缓存"];
            break;
        case 3:
            [cell setText:@"同步"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)setUser:(NSString*)userName withEmail:(NSString*)email withPhone:(NSString*)phone withAvatar:(UIImage*)avatar {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSAttributedString* info = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"姓名 %@\n邮箱 %@\n电话 %@",userName,email,phone] attributes:attributes];
    [self infoView].attributedText = info;
    [[self avatarView] setImage:avatar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"我的"];
}

- (UITextView *)infoView {
    if (_infoView == nil) {
        _infoView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, 300, 200, 90)];
        [_infoView.layer setBorderColor:UIColor.grayColor.CGColor];
        [_infoView.layer setBorderWidth:1];
        [_infoView setEditable:false];
        [self.view addSubview:_infoView];
    }
    
    return _infoView;
}

- (UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 75, 120, 150, 150)];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 75;
        [_avatarView.layer setBorderWidth:1];
        _avatarView.layer.borderColor=[UIColor grayColor].CGColor;
        [self.view addSubview:_avatarView];
    }
    return _avatarView;
}

- (UITableView *)menuTable {
    if (_menuTable == nil) {
        _menuTable = [[UITableView alloc] initWithFrame:CGRectMake(50, 450, self.view.bounds.size.width - 100, 200)];
        [_menuTable.layer setBorderColor:UIColor.grayColor.CGColor];
        [_menuTable.layer setBorderWidth:1];
        [_menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_menuTable];
        _menuTable.dataSource = self;
    }
    return _menuTable;
}

- (void)viewDidLoad {
    [self infoView];
    [self avatarView];
    [self menuTable];
    
    UILabel* about = [[UILabel alloc] initWithFrame:CGRectMake(50, 420, 100, 30)];
    [about setText:@"关于"];
    [self.view addSubview:about];
}

@end
