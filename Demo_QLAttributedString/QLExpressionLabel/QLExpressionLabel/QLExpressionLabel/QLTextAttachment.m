//
//  QLTextAttachment.m
//  QLExpressionLabel
//
//  Created by Shrek on 14/12/23.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import "QLTextAttachment.h"

@implementation QLTextAttachment

- (void)setExpressionModel:(QLExpressionModel *)expressionModel {
    _expressionModel = expressionModel;
    
    NSString *strFikeName = [NSString stringWithFormat:@"%@.png", expressionModel.strImageName];
    NSString *strFilePath = [[NSBundle mainBundle] pathForResource:strFikeName ofType:nil];
    [self setImage:[UIImage imageWithContentsOfFile:strFilePath]];
}

@end
