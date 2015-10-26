//
//  QLTextView.m
//  Demo_QLTextView
//
//  Created by Shrek on 15/3/30.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLTextView.h"

@implementation QLTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefaultSetting];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadDefaultSetting];
}

// 加载UI和默认的数据
- (void)loadDefaultSetting {
    // 监听super的文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange {
    // 重绘（重新调用）
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *dicAttributes = [NSMutableDictionary dictionary];
    dicAttributes[NSFontAttributeName] = self.font == nil ? [UIFont systemFontOfSize:15] : self.font;
    dicAttributes[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    // 画文字
    //[self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:dicAttributes];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
