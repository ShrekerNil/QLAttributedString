//
//  QLEmotionTextView.h
//  QLEmotion
//
//  Created by Shrek on 15/5/14.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLTextView.h"
#import "QLTextAttachment.h"

@interface QLEmotionTextView : QLTextView

- (void)insertEmotion:(QLEmotionModel *)emotionModel;
- (NSString *)descriptionText;

@end
