//
//  QLExpressionString.h
//  QLExpressionLabel
//
//  Created by Shrek on 15/1/18.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLExpressionString : NSAttributedString

//@property (nonatomic, copy) NSAttributedString *str<#variable#>;

+ (instancetype)expressionStringWithString:(NSString *)strTextWithExpressionChars;

@end
