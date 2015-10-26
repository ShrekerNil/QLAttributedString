//
//  QLEmotionTabBar.h
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QLEmotionTabBarTypeRecent,
    QLEmotionTabBarTypeDefault,
    QLEmotionTabBarTypeEmoji,
    QLEmotionTabBarTypeWaveFlower
} QLEmotionTabBarType;

@interface QLEmotionTabBar : UIView

@property (nonatomic, copy) void (^blkDidSelectTabBarType)(QLEmotionTabBarType selectedType);

@end
