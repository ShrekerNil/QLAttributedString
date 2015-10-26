//
//  QLEmotionPageView.m
//  QLEmotion
//
//  Created by Shrek on 15/5/13.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLEmotionPageView.h"
#import "QLEmotionButton.h"

CGFloat const QLEmotionPageViewPadding = 10;
NSUInteger const QLEmotionPageViewRowCount = 3;
NSUInteger const QLEmotionPageViewColumnCount = 7;

@implementation QLEmotionPageView
{
    __weak UIButton *_btnDelete;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDelete setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [btnDelete setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDelete];
    _btnDelete = btnDelete;
    
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)]];
}

#pragma mark - Actions
- (void)deleteAction:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:QLEmotionDidDeleteEmotionNotification object:nil];
}
- (void)longPressAction:(UILongPressGestureRecognizer *)grLongPress {
    switch (grLongPress.state) {
        case UIGestureRecognizerStateBegan:
            //QLLog(@"%@", @"UIGestureRecognizerStateBegan");
            break;
        case UIGestureRecognizerStateChanged:
            //QLLog(@"%@", @"UIGestureRecognizerStateChanged");
            //[self handleLongPressEnd:grLongPress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            //QLLog(@"%@", @"UIGestureRecognizerStateEnded|Cancelled");
            [self handleLongPressEnd:grLongPress];
            break;
            
        default:
            break;
    }
}

- (void)handleLongPressEnd:(UILongPressGestureRecognizer *)grLongPress {
    CGPoint point = [grLongPress locationInView:self];
    QLEmotionButton *button = [self emotionButtonFromLocation:point];
    if (button) {
        [self emotionAction:button];
    }
}

- (QLEmotionButton *)emotionButtonFromLocation:(CGPoint)location {
    NSUInteger countEmotions = _arrEmotions.count;
    for (NSUInteger index = 0; index < countEmotions; index ++) {
        QLEmotionButton *button = self.subviews[index+1];
        if (CGRectContainsPoint(button.frame, location)) { // 已经找到
            return button;
        }
    }
    return nil;
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize sizeSelf = self.frame.size;
    
    NSUInteger countEmotions = _arrEmotions.count;
    CGFloat fWidthButon = (sizeSelf.width - 2 * QLEmotionPageViewPadding) / QLEmotionPageViewColumnCount;
    CGFloat fHeightButon = (sizeSelf.height - QLEmotionPageViewPadding) / QLEmotionPageViewRowCount;
    if (countEmotions) {
        for (NSUInteger index = 0; index < countEmotions; index ++) {
            QLEmotionButton *button = self.subviews[index+1];
            CGFloat fXbutton = QLEmotionPageViewPadding + (index%QLEmotionPageViewColumnCount)*fWidthButon;
            CGFloat fYbutton = QLEmotionPageViewPadding + (index/QLEmotionPageViewColumnCount)*fHeightButon;
            button.frame = CGRectMake(fXbutton, fYbutton, fWidthButon, fHeightButon);
            [button addTarget:self action:@selector(emotionAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    CGFloat fXBtnDelete = sizeSelf.width - QLEmotionPageViewPadding - fWidthButon;
    CGFloat fYBtnDelete = sizeSelf.height - fWidthButon;
    CGRect rectBtnDelete = CGRectMake(fXBtnDelete, fYBtnDelete, fWidthButon, fHeightButon);
    [_btnDelete setFrame:rectBtnDelete];
}

- (void)setArrEmotions:(NSArray *)arrEmotions {
    _arrEmotions = arrEmotions;
    
    NSUInteger countEmotions = arrEmotions.count;
    for (NSUInteger index = 0; index < countEmotions; index ++) {
        QLEmotionButton *button = [QLEmotionButton buttonWithType:UIButtonTypeSystem];
        [button setEmotionModel:arrEmotions[index]];
        [self addSubview:button];
    }
}

#pragma mark - Actions
- (void)emotionAction:(QLEmotionButton *)button {
    NSDictionary *dicUserInfo = @{QLEmotionSelectEmotionKey: button.emotionModel};
    [[NSNotificationCenter defaultCenter] postNotificationName:QLEmotionDidSelectEmotionNotification object:nil userInfo:dicUserInfo];
}

@end
