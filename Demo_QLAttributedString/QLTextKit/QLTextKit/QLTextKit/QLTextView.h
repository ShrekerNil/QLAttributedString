//
//  QLTextView.h
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLCoreTextData.h"

extern NSString * const QLTextViewImageTapedNotification;
extern NSString * const QLTextViewLinkTapedNotification;

@interface QLTextView : UIView

@property (strong, nonatomic) QLCoreTextData *data;

@end
