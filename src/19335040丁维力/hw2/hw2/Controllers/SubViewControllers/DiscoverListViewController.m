//
//  DiscoverListViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverListViewController.h"
#import "../../Models/CheckinModel.h"
#import "../../Views/CheckinItemView.h"
#import "../../AppDelegate.h"
#import "DiscoverDetailViewController.h"

@interface DiscoverListViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *filteredDataArray;
@property (nonatomic, strong) UITextField *searchBox;

@end

@implementation DiscoverListViewController

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
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (void)sortFilteredData {
    NSArray* result = [self.filteredDataArray sortedArrayUsingComparator:^NSComparisonResult(CheckinModel*  _Nonnull obj1, CheckinModel*  _Nonnull obj2) {
        return [obj2.date compare:obj1.date];
    }];
    [self.filteredDataArray removeAllObjects];
    for (int i = 0; i < result.count; i++) {
        [self.filteredDataArray addObject:result[i]];
    }
}

- (void)entryDidAdded:(CheckinModel *)model {
    if (self.searchBox.text.length == 0 || [model.thought rangeOfString:self.searchBox.text].location != NSNotFound ||
        [model.clothing rangeOfString:self.searchBox.text].location != NSNotFound ||
        [model.place rangeOfString:self.searchBox.text].location != NSNotFound ||
        [[[CheckinModel getDateFormatter] stringFromDate:model.date] rangeOfString:self.searchBox.text].location != NSNotFound) {
        [self.filteredDataArray addObject:model];
        [self sortFilteredData];
        [self.collectionView reloadData];
        [self.collectionView reloadInputViews];
    }
}

- (void)entryDidRemoved:(CheckinModel *)model {
    if ([self.filteredDataArray containsObject:model]) {
        [self.filteredDataArray removeObject:model];
        [self.collectionView reloadData];
        [self.collectionView reloadInputViews];
    }
}

- (void)viewDidLoad {
    [self.view addSubview:[self searchBox]];
    [self.view addSubview:[self collectionView]];
    [self.collectionView registerClass:[CheckinItemView class] forCellWithReuseIdentifier:@"cell"];
    
    self.filteredDataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [AppDelegate getCheckinRecords].count; i++) {
        [self.filteredDataArray addObject:[AppDelegate getCheckinRecords][i]];
    }
    [self sortFilteredData];
    [AppDelegate setChangeDelegate:self];
    
    UIColor *topleftColor = [UIColor colorWithRed:135/255.0f green:206/255.0f blue:235/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:190/255.0f alpha:1.0f];
    UIImage *bgImg = [self gradientColorImageFromColors:@[topleftColor, bottomrightColor] imgSize:self.view.bounds.size];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"穿搭记录"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredDataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CheckinItemView *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CheckinModel* model = self.filteredDataArray[indexPath.row];
    [cell setModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CheckinModel* model = self.filteredDataArray[indexPath.row];
    DiscoverDetailViewController* detail = [[DiscoverDetailViewController alloc] initWithModel:model];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:detail animated:true];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.origin.y + 150, self.view.bounds.size.width - 20, self.view.bounds.size.height - 150) collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:UIColor.clearColor];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
    }
    return _collectionView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.filteredDataArray removeAllObjects];
    for (int i = 0; i < [AppDelegate getCheckinRecords].count; i++) {
        CheckinModel* model = [AppDelegate getCheckinRecords][i];
        if (textField.text.length == 0 || [model.thought rangeOfString:textField.text].location != NSNotFound ||
            [model.clothing rangeOfString:self.searchBox.text].location != NSNotFound ||
            [model.place rangeOfString:self.searchBox.text].location != NSNotFound ||
            [[[CheckinModel getDateFormatter] stringFromDate:model.date] rangeOfString:self.searchBox.text].location != NSNotFound) {
            [self.filteredDataArray addObject:model];
        }
    }
    [self sortFilteredData];
    [self.collectionView reloadData];
    [self.collectionView reloadInputViews];
    return true;
}

- (UITextField *)searchBox {
    if (_searchBox == nil) {
        _searchBox = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.origin.y + 110, self.view.bounds.size.width - 20, 30)];
        [_searchBox setPlaceholder:@"搜索框"];
        [_searchBox setDelegate:self];
        [_searchBox setReturnKeyType:UIReturnKeySearch];
        [_searchBox.layer setBorderWidth:1];
        [_searchBox.layer setBorderColor:UIColor.grayColor.CGColor];
    }
    return _searchBox;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
