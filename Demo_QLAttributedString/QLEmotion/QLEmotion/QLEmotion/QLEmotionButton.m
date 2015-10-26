//
//  QLEmotionButton.m
//  QLEmotion
//
//  Created by Shrek on 15/5/14.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLEmotionButton.h"
#import "NSString+Emoji.h"

@implementation QLEmotionButton

- (void)setEmotionModel:(QLEmotionModel *)emotionModel {
    _emotionModel = emotionModel;
    if (emotionModel.code) {
        [self setTitle:emotionModel.emoji forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:32]];
    } else {
        [self setImage:[[UIImage imageNamed:emotionModel.png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}

@end
