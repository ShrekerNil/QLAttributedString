//
//  QLEmotionTextView.m
//  QLEmotion
//
//  Created by Shrek on 15/5/14.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLEmotionTextView.h"
#import "UITextView+QLTextView.h"

@implementation QLEmotionTextView

- (NSString *)descriptionText {
    NSMutableString *strDescriptionText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        QLTextAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment == nil) { // Emoji 或者 普通文本
            NSAttributedString *strAttributed = [self.attributedText attributedSubstringFromRange:range];
            [strDescriptionText appendString:strAttributed.string];
        } else {
            [strDescriptionText appendString:attachment.emotionModel.chs];
        }
    }];
    return [strDescriptionText copy];
}

- (void)insertEmotion:(QLEmotionModel *)emotionModel {
    if (emotionModel.chs) { // 选中图片表情
        [self handleImageEmotion:emotionModel];
    } else { // 选中Emoji
        [self insertText:emotionModel.emoji];
    }
}

- (void)handleImageEmotion:(QLEmotionModel *)emotionModel {
    QLTextAttachment *attachMent = [[QLTextAttachment alloc] init];
    attachMent.emotionModel = emotionModel;
    CGFloat fHWLine = self.font.lineHeight;
    [attachMent setBounds:CGRectMake(0, -3, fHWLine, fHWLine)];
    NSAttributedString *strAttributed = [NSAttributedString attributedStringWithAttachment:attachMent];
    
    [self insertAttributedString:strAttributed OperationsBeforeAssignment:^(NSMutableAttributedString *strMAttDialog) {
        [strMAttDialog addAttributes:@{NSFontAttributeName: self.font} range:NSMakeRange(0, strMAttDialog.length)];
    }];
}

@end
