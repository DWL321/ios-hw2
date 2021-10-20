//
//  DiscoverDetailViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverDetailViewController.h"

@interface DiscoverDetailViewController()

@property (nonatomic, strong) CheckinModel* model;
@property (nonatomic, strong) UICollectionView* images;

@end

@implementation DiscoverDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"详细"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.images dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (int i = 0; i < cell.subviews.count; i++) {
        [cell.subviews[i] removeFromSuperview];
    }
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 80) / 3, (self.view.bounds.size.width - 80) / 3 * 0.8)];
    [view setContentMode:UIViewContentModeScaleToFill];
    [view setImage:self.model.images[indexPath.row]];
    [cell addSubview:view];
    return cell;
}

-(DiscoverDetailViewController*)initWithModel:(CheckinModel*)model {
    self = [super init];
    _model = model;
    
    UITextView* dateView = [[UITextView alloc] initWithFrame:CGRectMake(30, 120, self.view.bounds.size.width - 60, 30)];
    [dateView setText:[[CheckinModel getDateFormatter] stringFromDate:model.date]];
    UIFont* font = [UIFont fontWithName:dateView.font.fontName size:16];
    [dateView setFont:font];
    [dateView setEditable:false];
    [dateView setBackgroundColor:UIColor.clearColor];
    [self.view addSubview:dateView];
    
    UITextView* placeView = [[UITextView alloc] initWithFrame:CGRectMake(30, 160, self.view.bounds.size.width - 60, 30)];
    [placeView setText:model.place];
    [placeView setFont:font];
    [placeView setEditable:false];
    [placeView setBackgroundColor:UIColor.clearColor];
    [self.view addSubview:placeView];
    
    UITextView* clothingView = [[UITextView alloc] initWithFrame:CGRectMake(30, 200, self.view.bounds.size.width - 60, 30)];
    [clothingView setText:model.clothing];
    [clothingView setFont:font];
    [clothingView setEditable:false];
    [clothingView setBackgroundColor:UIColor.clearColor];
    [self.view addSubview:clothingView];
    
    UITextView* thoughtView = [[UITextView alloc] initWithFrame:CGRectMake(30, 240, self.view.bounds.size.width - 60, 0) ];
    [thoughtView setText:model.thought];
    [thoughtView setFont:font];
    [thoughtView setEditable:false];
    [thoughtView setBackgroundColor:UIColor.clearColor];
    CGRect frame = thoughtView.frame;
    frame.size.height = [thoughtView contentSize].height * 2;
    [thoughtView setFrame:frame];
    
    [self.view addSubview:thoughtView];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake((self.view.bounds.size.width - 80) / 3, (self.view.bounds.size.width - 80) / 3 * 0.8)];
    [layout setMinimumLineSpacing:10];
    [layout setMinimumInteritemSpacing:10];
    _images = [[UICollectionView alloc] initWithFrame:CGRectMake(30, 260 + frame.size.height, self.view.bounds.size.width - 60, self.view.bounds.size.height - 400) collectionViewLayout:layout];
    [_images setBackgroundColor:UIColor.clearColor];
    [_images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_images setDataSource:self];
    
    [self.view addSubview:_images];
    
    return self;
}

@end
