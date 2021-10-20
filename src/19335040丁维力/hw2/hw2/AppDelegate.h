//
//  AppDelegate.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Models/CheckinModel.h"


@protocol RecordChangeNotify <NSObject>

@required
- (void)entryDidAdded:(CheckinModel*) model;
- (void)entryDidRemoved:(CheckinModel*) model;

@end

static NSMutableArray *dataArray;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
}

@property (strong, nonatomic) UIWindow *window;

+(void)addCheckinRecord:(CheckinModel*)model;
+(void)removeCheckinRecord:(CheckinModel*)model;
+(NSMutableArray*)getCheckinRecords;
+(void)setChangeDelegate:(id <RecordChangeNotify>)delegate;

@end

