//
//  QLExpressionString.m
//  QLExpressionLabel
//
//  Created by Shrek on 15/1/18.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLExpressionString.h"
#import "RegexKitLite.h"
#import "QLRegexResultModel.h"
#import "QLTextAttachment.h"
#import "QLExpressionModel.h"



@implementation QLExpressionString

+ (instancetype)expressionStringWithString:(NSString *)strTextWithExpressionChars {
    NSMutableAttributedString *strMAttributed = [[NSMutableAttributedString alloc] init];
    
    // @"换个v烦烦烦烦烦烦/em0010/em0009爱哭鬼/em0013/em0014/em0014/em0014/em0018啊水电费噶色排骨饭/em0018"
    NSString *strRegex = @"/em\\d{4}"; // 汉字的范围:\u4e00-\u9fa5
    
    NSMutableArray *arrMRegexModels = [NSMutableArray array];
    // 获取表情数组
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"QLExpression.plist" ofType:nil];
    NSArray *arrExpressions = [NSArray arrayWithContentsOfFile:strPath];
    NSMutableArray *arrMExpressionModels = [NSMutableArray array];
    for (NSDictionary *dic in arrExpressions) {
        QLExpressionModel *model = [[QLExpressionModel alloc] initWithDictionary:dic];
        [arrMExpressionModels addObject:model];
    }
    
    // 匹配表情
    [strTextWithExpressionChars enumerateStringsMatchedByRegex:strRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length != 0) {
            QLRegexResultModel *model = [[QLRegexResultModel alloc] init];
            [model setStrText:*capturedStrings];
            [model setRange:*capturedRanges];
            [model setIsEmotion:YES];
            [arrMRegexModels addObject:model];
        }
    }];
    
    // 匹配非表情
    [strTextWithExpressionChars enumerateStringsSeparatedByRegex:strRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length != 0) {
            QLRegexResultModel *model = [[QLRegexResultModel alloc] init];
            [model setStrText:*capturedStrings];
            [model setRange:*capturedRanges];
            [model setIsEmotion:NO];
            [arrMRegexModels addObject:model];
        }
    }];
    
    // 排序
    [arrMRegexModels sortUsingComparator:^NSComparisonResult(QLRegexResultModel *model1, QLRegexResultModel *model2) {
        NSUInteger location1 = model1.range.location;
        NSUInteger location2 = model2.range.location;
        return [@(location1) compare:@(location2)];
        /*
        if (location1 < location2) {
            return NSOrderedAscending; // 升序
        } else if (location1 > location2) {
            return NSOrderedDescending; // 降序
        } else {
            return NSOrderedSame; // 一样大
        } */
    }];
    
    [arrMRegexModels enumerateObjectsUsingBlock:^(QLRegexResultModel *model, NSUInteger idx, BOOL *stop) {
        NSLog(@"~%@---%@", model.strText, NSStringFromRange(model.range));
        if (model.isEmotion) {
            QLTextAttachment *textAttachment = [[QLTextAttachment alloc] init];
            
            for (QLExpressionModel *expressionModel in arrMExpressionModels) {
                if ([model.strText isEqualToString:expressionModel.strContentName]) {
                    textAttachment.expressionModel = expressionModel;
                    break;
                }
            }
            
            UIFont *font = [UIFont systemFontOfSize:15];
            [textAttachment setBounds:CGRectMake(0, -4, font.lineHeight, font.lineHeight)];
            
            NSAttributedString *strAttributedTemp = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [strMAttributed appendAttributedString:strAttributedTemp];
        } else {
            NSAttributedString *strTemp = [[NSAttributedString alloc] initWithString:model.strText];
            [strMAttributed appendAttributedString:strTemp];
        }
    }];
    
    
    return (QLExpressionString *)strMAttributed;
}

@end
