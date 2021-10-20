//
//  CheckinItemView.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckinItemView.h"

@interface CheckinItemView()

@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* dateContent;
@property (nonatomic, strong) UILabel* placeLabel;
@property (nonatomic, strong) UILabel* placeContent;
@property (nonatomic, strong) UILabel* clothingLabel;
@property (nonatomic, strong) UILabel* clothingContent;

@end

@implementation CheckinItemView

- (void)initData {
    if (_dateLabel != nil) return;
    [self dateLabel];
    [self placeLabel];
    [self clothingLabel];
    
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:UIColor.grayColor.CGColor];
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:true];
}

- (void)setModel:(CheckinModel *)model {
    [self initData];
    [[self dateContent] setText:[[CheckinModel getDateFormatter] stringFromDate:model.date]];
    [[self placeContent] setText:model.place];
    [[self clothingContent] setText:model.clothing];
    _model = model;
}

- (UILabel *)dateContent {
    if (_dateContent == nil) {
        _dateContent = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.bounds.size.width - 70, 20)];
        [self addSubview:_dateContent];
    }
    return _dateContent;
}

- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
        [_dateLabel setText:@"日期"];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)placeContent {
    if (_placeContent == nil) {
        _placeContent = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, self.bounds.size.width - 70, 20)];
        [self addSubview:_placeContent];
    }
    return _placeContent;
}

- (UILabel *)placeLabel {
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 50, 20)];
        [_placeLabel setText:@"地点"];
        [self addSubview:_placeLabel];
    }
    return _placeLabel;
}

- (UILabel *)clothingContent {
    if (_clothingContent == nil) {
        _clothingContent = [[UILabel alloc] initWithFrame:CGRectMake(60, 70, self.bounds.size.width - 100, 20)];
        [self addSubview:_clothingContent];
    }
    return _clothingContent;
}

- (UILabel *)clothingLabel {
    if (_clothingLabel == nil) {
        _clothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 20)];
        [_clothingLabel setText:@"穿搭"];
        [self addSubview:_clothingLabel];
    }
    return _clothingLabel;
}

@end
