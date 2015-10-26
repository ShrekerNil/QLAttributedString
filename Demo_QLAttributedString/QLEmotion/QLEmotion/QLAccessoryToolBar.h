//
//  QLAccessoryToolBar.h
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLAccessoryToolBar : UIView

@property (nonatomic, assign) BOOL shouldShowSystemIcon;
@property (nonatomic, copy) void (^blkDidSelectEmotionButton)(UIButton *button);

@end
