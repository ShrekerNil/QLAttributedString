//
//  QLRegexResultModel.h
//  QLExpressionLabel
//
//  Created by Shrek on 15/1/18.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLRegexResultModel : NSObject

@property (nonatomic, copy) NSString *strText; // 文字
@property (nonatomic, assign) NSRange range; // 范围
@property (nonatomic, assign) BOOL isEmotion; // 是否是表情

@end
