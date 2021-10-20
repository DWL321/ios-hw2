//
//  CheckinModel.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#ifndef CheckinModel_h
#define CheckinModel_h

static NSDateFormatter *formatter;

@interface CheckinModel : NSObject

@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* place;
@property (nonatomic, strong) NSString* clothing;
@property (nonatomic, strong) NSString* thought;
@property (nonatomic, strong) NSMutableArray* images;

+(NSDateFormatter*)getDateFormatter;

@end


#endif /* CheckinModel_h */
