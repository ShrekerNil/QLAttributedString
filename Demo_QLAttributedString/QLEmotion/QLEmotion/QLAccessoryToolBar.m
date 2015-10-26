//
//  QLAccessoryToolBar.m
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLAccessoryToolBar.h"

@implementation QLAccessoryToolBar
{
    UIButton *_button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(selectEmotionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    _button = button;
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    _button.frame = self.bounds;
}

- (void)selectEmotionButtonAction:(UIButton *)button {
    if (_blkDidSelectEmotionButton) {
        _blkDidSelectEmotionButton(button);
    }
}

- (void)setShouldShowSystemIcon:(BOOL)shouldShowSystemIcon {
    _shouldShowSystemIcon = shouldShowSystemIcon;
    
    NSString *strImageName = @"compose_emoticonbutton_background";
    NSString *strImageNameSelected = @"compose_emoticonbutton_background_highlighted";
    if (shouldShowSystemIcon) { // 显示系统键盘Icon
        strImageName = @"compose_keyboardbutton_background";
        strImageNameSelected = @"compose_keyboardbutton_background_highlighted";
    }
    [_button setImage:[UIImage imageNamed:strImageName] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:strImageNameSelected] forState:UIControlStateHighlighted];
}

@end
