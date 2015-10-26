//
//  UITextView+QLTextView.m
//  QLEmotion
//
//  Created by Shrek on 15/5/14.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "UITextView+QLTextView.h"

@implementation UITextView (QLTextView)

- (void)insertAttributedString:(NSAttributedString *)attributedString OperationsBeforeAssignment:(OperationsBeforeInsertBlock)ops {
    NSRange rangeOld = self.selectedRange;
    NSMutableAttributedString *strMAttDialog = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [strMAttDialog insertAttributedString:attributedString atIndex:self.selectedRange.location];
    if (ops) {
        ops(strMAttDialog);
    }
    self.attributedText = [strMAttDialog copy];
    rangeOld.location += 1;
    self.selectedRange = rangeOld;
}

@end
