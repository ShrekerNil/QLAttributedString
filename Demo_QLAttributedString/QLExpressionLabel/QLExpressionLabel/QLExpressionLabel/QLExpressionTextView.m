//
//  QLExpressionTextView.m
//  QLExpressionLabel
//
//  Created by Shrek on 14/12/23.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import "QLExpressionTextView.h"
#import "QLTextAttachment.h"

@interface QLExpressionTextView () <UITextViewDelegate>
{
    NSArray *_arrExpressions;
    NSString *_strText;
}

@end

@implementation QLExpressionTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    [self setDelegate:self];
    [self setAllowsEditingTextAttributes:YES];
    
    // 把所有的表情取出来放在一个数组中
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"QLExpression" ofType:@"plist"];
    _arrExpressions = [NSArray arrayWithContentsOfFile:strPath];
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 屏蔽系统的Emoji图标
    BOOL isTrue = [self isContainsEmoji:text];
    if (isTrue) {
        //[MBProgressHUD showHUDErrorWithTextString:@"非法字符" inView:kKeyWindow Delay:1.0];
        return NO;
    }
    // 处理返回
    NSLog(@"%s~textView.text:%@", __FUNCTION__, textView.text);
    if (_strText == nil) {
        _strText = @"";
    }
    NSMutableString *strMTemp = [_strText mutableCopy];
    [strMTemp appendString:text];
    _strText = strMTemp;
    NSLog(@"%s~_strText:%@", __FUNCTION__, _strText);
    
    // 处理自带Emoji图标
    if ([text hasPrefix:@"/em"]) {
        // 处理显示
        NSDictionary *dicFinal = nil;
        for (NSDictionary *dicTemp in _arrExpressions) {
            NSString *strExpression = dicTemp[@"contentName"];
            if ([strExpression isEqualToString:text]) {
                dicFinal = dicTemp;
                break;
            }
        }
        //新建文字附件来存放我们的图片
        QLTextAttachment *textAttachment = [[QLTextAttachment alloc] init];
        //给附件添加图片
        textAttachment.image = [UIImage imageNamed:dicFinal[@"imageName"]];
        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
        NSAttributedString *strImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        NSMutableAttributedString *strMAttribute = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
        [strMAttribute appendAttributedString:strImage];
        [textView setAttributedText:strMAttribute];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isContainsEmoji:(NSString *)string {
    /*该方法现在还存在缺陷:表情:❤️,☝️,✌️,☺️没有得到处理*/
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

@end
