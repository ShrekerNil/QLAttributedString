//
//  QLEmotionTabBar.m
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLEmotionTabBar.h"

@implementation QLEmotionTabBar
{
    UIButton *_currentItem;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    NSArray *arrTitles = @[@"最近", @"默认", @"Emoji", @"浪小花"];
    NSUInteger count = arrTitles.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:arrTitles[index] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [item.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [item setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [item setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchDown];
        [item setAdjustsImageWhenHighlighted:NO];
        item.tag = index;
        [self addSubview:item];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat fItemWidth = CGRectGetWidth(self.frame) / count;
    CGFloat fItemHeight = CGRectGetHeight(self.frame);
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *item = self.subviews[index];
        [item setFrame:CGRectMake(index*fItemWidth, 0, fItemWidth, fItemHeight)];
    }
}

- (void)itemAction:(UIButton *)item {
    if (item == _currentItem) return;
    
    item.selected = YES;
    _currentItem.selected = NO;
    _currentItem = item;
    
    if (_blkDidSelectTabBarType) {
        _blkDidSelectTabBarType((int)item.tag);
    }
}

- (void)setBlkDidSelectTabBarType:(void (^)(QLEmotionTabBarType))blkDidSelectTabBarType {
    _blkDidSelectTabBarType = [blkDidSelectTabBarType copy];
    UIButton *btnDefault = (UIButton *)[self viewWithTag:QLEmotionTabBarTypeDefault];
    [self itemAction:btnDefault];
}

@end
