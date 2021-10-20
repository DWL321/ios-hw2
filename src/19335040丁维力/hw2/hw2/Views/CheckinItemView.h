//
//  CheckinItemView.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#ifndef CheckinItemView_h
#define CheckinItemView_h
#import <UIKit/UIKit.h>
#import "../Models/CheckinModel.h"

@interface CheckinItemView : UICollectionViewCell
@property (nonatomic, strong) CheckinModel* model;
@end

#endif /* CheckinItemView_h */
