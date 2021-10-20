//
//  UITextView+PlaceHolder.h
//  hw2
//
//  Created by student14 on 2021/10/19.
//  Copyright © 2021 sysu. All rights reserved.
//

#ifndef UITextView_PlaceHolder_h
#define UITextView_PlaceHolder_h

#import <UIKit/UIKit.h>
//系统版本
#define HKVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@interface UITextView (Placeholder)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor;

@end

#endif /* UITextView_PlaceHolder_h */
