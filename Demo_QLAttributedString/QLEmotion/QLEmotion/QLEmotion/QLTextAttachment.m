//
//  QLTextAttachment.m
//  QLEmotion
//
//  Created by Shrek on 15/5/15.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLTextAttachment.h"

@implementation QLTextAttachment

- (void)setEmotionModel:(QLEmotionModel *)emotionModel {
    _emotionModel = emotionModel;
    self.image = [UIImage imageNamed:emotionModel.png];
}

@end
