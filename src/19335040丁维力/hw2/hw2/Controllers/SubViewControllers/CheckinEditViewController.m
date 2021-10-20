//
//  CheckinEditViewController.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckinEditViewComtroller.h"
#import "../../AppDelegate.h"
#import "../../Views/UITextView+Placeholder.h"

@interface CheckinEditViewController() {
    NSMutableArray* imageArray;
}
@property (nonatomic, strong) UITextField* dateInput;
@property (nonatomic, strong) UITextField* placeInput;
@property (nonatomic, strong) UITextField* clothingInput;
@property (nonatomic, strong) UITextView* thoughtInput;
@property (nonatomic, strong) UICollectionView* images;
@property (nonatomic, strong) UIButton* addButton;
@end

@implementation CheckinEditViewController

- (void)alertAnimation:(UIView*) target {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat angle = M_PI_4 / 9.0;
    NSArray *array = @[@(angle), @(-angle), @(angle)];
    [animation setValues:array];
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:true];
    animation.duration = 0.2f;
    [animation setRepeatCount:1];
    [target.layer addAnimation:animation forKey:nil];
    
}

- (void)pickPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageArray addObject:image];
    [self.images reloadData];
    [self.images reloadInputViews];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArray.count + 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == imageArray.count) {
        [self pickPhoto];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.images dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (int i = 0; i < cell.subviews.count; i++) {
        [cell.subviews[i] removeFromSuperview];
    }
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 120) / 3, (self.view.bounds.size.width - 120) / 3 * 0.8)];
    [view setContentMode:UIViewContentModeScaleToFill];
    
    if (indexPath.row == imageArray.count) {
        [view setImage:[UIImage imageNamed:@"add.png"]];
    }
    else {
        [view setImage:imageArray[indexPath.row]];
    }
    [cell addSubview:view];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"添加记录"];
}

- (UICollectionView *)images {
    if (_images == nil) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake((self.view.bounds.size.width - 120) / 3, (self.view.bounds.size.width - 120) / 3 * 0.8)];
        [layout setMinimumLineSpacing:10];
        [layout setMinimumInteritemSpacing:10];
        _images = [[UICollectionView alloc] initWithFrame:CGRectMake(80, 500, self.view.bounds.size.width - 100, self.view.bounds.size.height - 640) collectionViewLayout:layout];
        [_images setBackgroundColor:UIColor.clearColor];
        [_images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_images setDelegate:self];
        [_images setDataSource:self];
    }
    
    return _images;
}

- (UITextView *)thoughtInput {
    if (_thoughtInput == nil) {
        _thoughtInput = [[UITextView alloc] initWithFrame:CGRectMake(120, 240, self.view.bounds.size.width - 140, 240)];
        [_thoughtInput setPlaceholder:@"多行输入" placeholdColor:[UIColor lightGrayColor]];
        [self.thoughtInput setText:@"1"];
        [self.thoughtInput setText:@""];
        [_thoughtInput.layer setBorderWidth:1];
        [_thoughtInput.layer setBorderColor:UIColor.grayColor.CGColor];
    }
    return _thoughtInput;
}

- (UITextField *)clothingInput {
    if (_clothingInput == nil) {
        _clothingInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 200, self.view.bounds.size.width - 140, 30)];
        [_clothingInput setPlaceholder:@"单行输入"];
        [_clothingInput.layer setBorderWidth:1];
        [_clothingInput.layer setBorderColor:UIColor.grayColor.CGColor];
    }
    return _clothingInput;
}

- (UITextField *)placeInput {
    if (_placeInput == nil) {
        _placeInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 160, self.view.bounds.size.width - 140, 30)];
        [_placeInput setPlaceholder:@"单行输入"];
        [_placeInput.layer setBorderWidth:1];
        [_placeInput.layer setBorderColor:UIColor.grayColor.CGColor];
    }
    return _placeInput;
}

- (UITextField *)dateInput {
    if (_dateInput == nil) {
        _dateInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 120, self.view.bounds.size.width - 140, 30)];
        [_dateInput setPlaceholder:@"单行输入"];
        
        [_dateInput setText:[[CheckinModel getDateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]]];
        
        [_dateInput.layer setBorderWidth:1];
        [_dateInput.layer setBorderColor:UIColor.grayColor.CGColor];
    }
    return _dateInput;
}

- (void)handleTouch:(UIButton *)button {
    CheckinModel *model = [[CheckinModel alloc] init];
    if ([[CheckinModel getDateFormatter] dateFromString:self.dateInput.text] == nil) {
        [self alertAnimation:self.dateInput];
        return;
    }
    [model setDate:[[CheckinModel getDateFormatter] dateFromString:self.dateInput.text]];
    if ([self.placeInput.text isEqualToString:@""]) {
        [self alertAnimation:self.placeInput];
        return;
    }
    [model setPlace:self.placeInput.text];
    if ([self.clothingInput.text isEqualToString:@""]) {
        [self alertAnimation:self.clothingInput];
        return;
    }
    [model setClothing:self.clothingInput.text];
    if ([self.thoughtInput.text isEqualToString:@""]) {
        [self alertAnimation:self.thoughtInput];
        return;
    }
    [model setThought:self.thoughtInput.text];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:imageArray copyItems:true];
    [model setImages:array];
    [AppDelegate addCheckinRecord:model];
    
    [self.clothingInput setText:@""];
    [self.placeInput setText:@""];
    [self.thoughtInput setText:@""];
    [self.dateInput setText:[[CheckinModel getDateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]]];
    [imageArray removeAllObjects];
    [self.images reloadData];
    [self.images reloadInputViews];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"发布成功";
    [label sizeToFit];
    label.center = self.view.center;
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.layer.cornerRadius = 5;
    [self.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        ViewController * parent = (ViewController *)[[self parentViewController] parentViewController];
        [parent setSelectedIndex:0];
    }];
}

- (UIButton *)addButton {
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addButton setTitle:@"提交" forState:UIControlStateNormal];
        [_addButton setFrame:CGRectMake(self.view.bounds.size.width/2 - 35, self.view.bounds.size.height - 130, 70, 30)];
        [_addButton.layer setBorderWidth:1];
        [_addButton.layer setBorderColor:UIColor.grayColor.CGColor];
        [_addButton addTarget:self action:@selector(handleTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (void)viewDidLoad {
    imageArray = [[NSMutableArray alloc] init];
    
    UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 30)];
    [timeLabel setText:@"时间"];
    
    UILabel* placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 30)];
    [placeLabel setText:@"地点"];
    
    UILabel* clothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 30)];
    [clothingLabel setText:@"搭配"];
    
    UILabel* thoughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 100, 30)];
    [thoughtLabel setText:@"心得"];
    
    UILabel* picLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 500, 100, 30)];
    [picLabel setText:@"配图"];
    
    [self.view addSubview:timeLabel];
    [self.view addSubview:placeLabel];
    [self.view addSubview:clothingLabel];
    [self.view addSubview:thoughtLabel];
    [self.view addSubview:picLabel];
    
    [self.view addSubview:[self dateInput]];
    [self.view addSubview:[self placeInput]];
    [self.view addSubview:[self clothingInput]];
    [self.view addSubview:[self thoughtInput]];
    
    [self.view addSubview:[self addButton]];
    
    [self.view addSubview:[self images]];
}

@end
