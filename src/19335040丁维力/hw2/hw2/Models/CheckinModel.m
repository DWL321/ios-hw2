//
//  CheckinModel.m
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckinModel.h"

@interface CheckinModel()

@end

@implementation CheckinModel

+(NSDateFormatter*)getDateFormatter {
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }
    
    return formatter;
}

@end
