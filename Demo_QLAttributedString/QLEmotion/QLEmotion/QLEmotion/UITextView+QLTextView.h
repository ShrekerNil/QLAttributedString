//
//  UITextView+QLTextView.h
//  QLEmotion
//
//  Created by Shrek on 15/5/14.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OperationsBeforeInsertBlock)(NSMutableAttributedString *strMAttDialog);

@interface UITextView (QLTextView)

- (void)insertAttributedString:(NSAttributedString *)attributedString OperationsBeforeAssignment:(OperationsBeforeInsertBlock)ops;

@end
