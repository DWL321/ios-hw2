//
//  DiscoverDetailViewController.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Models/CheckinModel.h"

@interface DiscoverDetailViewController : UIViewController<UICollectionViewDataSource>

-(DiscoverDetailViewController*)initWithModel:(CheckinModel*)model;

@end
