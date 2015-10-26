//
//  QLEmotionKeyBoard.m
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLEmotionKeyBoard.h"
#import "QLEmotionView.h"
#import "QLEmotionTabBar.h"

#import "QLEmotionModel.h"

@interface QLEmotionKeyBoard ()
{
    __weak QLEmotionTabBar *_tabBar;
    UIView *_viewDisplaying;
}

@property (nonatomic, strong) QLEmotionView *recentEmotionView;
@property (nonatomic, strong) QLEmotionView *defaultEmotionView;
@property (nonatomic, strong) QLEmotionView *emojiEmotionView;
@property (nonatomic, strong) QLEmotionView *waveFlowerEmotionView;

@end

@implementation QLEmotionKeyBoard

- (QLEmotionView *)recentEmotionView {
    if (!_recentEmotionView) {
        _recentEmotionView = [[QLEmotionView alloc] init];
    }
    return _recentEmotionView;
}

- (QLEmotionView *)defaultEmotionView {
    if (!_defaultEmotionView) {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"default_info.plist" ofType:nil];
        NSArray *arrDefaults = [NSArray arrayWithContentsOfFile:strPath];
        NSMutableArray *arrMDefaults = [NSMutableArray arrayWithCapacity:arrDefaults.count];
        [arrDefaults enumerateObjectsUsingBlock:^(NSDictionary *dicData, NSUInteger index, BOOL *stop) {
            QLEmotionModel *emojiModel = [[QLEmotionModel alloc] initWithDictionary:dicData];
            [arrMDefaults addObject:emojiModel];
        }];
        _defaultEmotionView = [[QLEmotionView alloc] init];
        _defaultEmotionView.arrEmotions = [arrMDefaults copy];
    }
    return _defaultEmotionView;
}

- (QLEmotionView *)emojiEmotionView {
    if (!_emojiEmotionView) {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"emoji_info.plist" ofType:nil];
        NSArray *arrDefaults = [NSArray arrayWithContentsOfFile:strPath];
        NSMutableArray *arrMEmojis = [NSMutableArray arrayWithCapacity:arrDefaults.count];
        [arrDefaults enumerateObjectsUsingBlock:^(NSDictionary *dicData, NSUInteger index, BOOL *stop) {
            QLEmotionModel *emojiModel = [[QLEmotionModel alloc] initWithDictionary:dicData];
            [arrMEmojis addObject:emojiModel];
        }];
        _emojiEmotionView = [[QLEmotionView alloc] init];
        _emojiEmotionView.arrEmotions = [arrMEmojis copy];
    }
    return _emojiEmotionView;
}
- (QLEmotionView *)waveFlowerEmotionView {
    if (!_waveFlowerEmotionView) {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"lxh_info.plist" ofType:nil];
        NSArray *arrDefaults = [NSArray arrayWithContentsOfFile:strPath];
        NSMutableArray *arrMWaveFlowers = [NSMutableArray arrayWithCapacity:arrDefaults.count];
        [arrDefaults enumerateObjectsUsingBlock:^(NSDictionary *dicData, NSUInteger index, BOOL *stop) {
            QLEmotionModel *emojiModel = [[QLEmotionModel alloc] initWithDictionary:dicData];
            [arrMWaveFlowers addObject:emojiModel];
        }];
        _waveFlowerEmotionView = [[QLEmotionView alloc] init];
        _waveFlowerEmotionView.arrEmotions = [arrMWaveFlowers copy];
    }
    return _waveFlowerEmotionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    QLEmotionTabBar *tabBar = [[QLEmotionTabBar alloc] init];
    [self addSubview:tabBar];
    _tabBar = tabBar;
    __weak typeof(self) selfWeak = self;
    [tabBar setBlkDidSelectTabBarType:^(QLEmotionTabBarType selectedType) {
        [_viewDisplaying removeFromSuperview];
        switch (selectedType) {
            case QLEmotionTabBarTypeRecent:
                [self addSubview:self.recentEmotionView];
                break;
            case QLEmotionTabBarTypeDefault:
                [self addSubview:self.defaultEmotionView];
                break;
            case QLEmotionTabBarTypeEmoji:
                [self addSubview:self.emojiEmotionView];
                break;
            case QLEmotionTabBarTypeWaveFlower:
                [self addSubview:self.waveFlowerEmotionView];
                break;
                
            default:
                break;
        }
        _viewDisplaying = [self.subviews lastObject];
        [selfWeak setNeedsLayout];
    }];
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize sizeSelf = self.frame.size;
    
    CGFloat fHeightEmotionTabBar = 37;
    CGRect rectEmotionTabBar = CGRectMake(0, sizeSelf.height - fHeightEmotionTabBar, sizeSelf.width, fHeightEmotionTabBar);
    _tabBar.frame = rectEmotionTabBar;
    
    CGRect rectEmotionView = CGRectMake(0, 0, sizeSelf.width, CGRectGetMinY(rectEmotionTabBar));
    _viewDisplaying.frame = rectEmotionView;
}

@end
