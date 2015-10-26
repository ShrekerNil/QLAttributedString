//
//  QLExpressionLabel.m
//  QLExpressionLabel
//
//  Created by Shrek on 14/12/22.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import "QLExpressionLabel.h"
#import "QLTextAttachment.h"

@implementation QLExpressionLabel

- (void)setStrContentWithExpression:(NSString *)strContentWithExpression {
    _strContentWithExpression = strContentWithExpression;
    
    // 匹配出表情位置,并替换成相应的表情
    NSString * pattern = @"/em\\d{4}";
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    // 匹配的结果
    NSArray *arrMachesResult = [regularExpression matchesInString:_strContentWithExpression options:0 range:NSMakeRange(0, _strContentWithExpression.length)];
    
    _countExpression = arrMachesResult.count;
    
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *arrMImages = [NSMutableArray arrayWithCapacity:arrMachesResult.count];
    
    // 获取表情数组
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"QLExpression.plist" ofType:nil];
    NSArray *arrExpressions = [NSArray arrayWithContentsOfFile:strPath];

    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in arrMachesResult) {
        //获取数组元素中得到range
        NSRange range = [match range];

        //获取原字符串中对应的值
        NSString *strExpression = [_strContentWithExpression substringWithRange:range];
        NSUInteger count = arrExpressions.count;
        for (int index = 0; index < count; index ++) {
            if ([arrExpressions[index][@"contentName"] isEqualToString:strExpression]) {
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                textAttachment.image = [UIImage imageNamed:arrExpressions[index][@"imageName"]];
                NSAttributedString *strImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
                NSMutableDictionary *dicMImages = [NSMutableDictionary dictionaryWithCapacity:2];
                [dicMImages setObject:strImage forKey:@"image"];
                [dicMImages setObject:[NSValue valueWithRange:range] forKey:@"range"];
                [arrMImages addObject:dicMImages];
            }
        }
    }
    NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:_strContentWithExpression];
    //从后往前替换
    int countExchange = (int)arrMImages.count;
    for (int index = countExchange -1; index >= 0; index--)
    {
        NSRange range;
        [arrMImages[index][@"range"] getValue:&range];
        //进行替换
        [strAttribute replaceCharactersInRange:range withAttributedString:arrMImages[index][@"image"]];
    }
    [self setAttributedText:strAttribute];
    
    // 笔记
    /**
     1. 返回所有匹配结果的集合(适合,从一段字符串中提取我们想要匹配的所有数据)
     *  - (NSArray *)matchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
     2. 返回正确匹配的个数(通过等于0,来验证邮箱,电话什么的,代替NSPredicate)
     *  - (NSUInteger)numberOfMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
     3. 返回第一个匹配的结果。注意，匹配的结果保存在  NSTextCheckingResult 类型中
     *  - (NSTextCheckingResult *)firstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
     4. 返回第一个正确匹配结果字符串的NSRange
     *  - (NSRange)rangeOfFirstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
     5. block方法
     *  - (void)enumerateMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range usingBlock:(void (^)(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop))block;
    
     enum {
     NSRegularExpressionCaseInsensitive			 = 1 << 0,   // 不区分大小写的
     NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,   // 忽略空格和# -
     NSRegularExpressionIgnoreMetacharacters		= 1 << 2,   // 整体化
     NSRegularExpressionDotMatchesLineSeparators	= 1 << 3,   // 匹配任何字符，包括行分隔符
     NSRegularExpressionAnchorsMatchLines		   = 1 << 4,   // 允许^和$在匹配的开始和结束行
     NSRegularExpressionUseUnixLineSeparators	   = 1 << 5,   // (查找范围为整个的话无效)
     NSRegularExpressionUseUnicodeWordBoundaries	= 1 << 6	// (查找范围为整个的话无效)
     };
     typedef NSUInteger NSRegularExpressionOptions;

    // 下面2个枚举貌似都没什么意义,除了在block方法中,一般情况下,直接给0吧
     enum {
     NSMatchingReportProgress		 = 1 << 0,
     NSMatchingReportCompletion	   = 1 << 1,
     NSMatchingAnchored			   = 1 << 2,
     NSMatchingWithTransparentBounds  = 1 << 3,
     NSMatchingWithoutAnchoringBounds = 1 << 4
     };
     typedef NSUInteger NSMatchingOptions;
     
    
     此枚举值只在5.block方法中用到
     enum {
     NSMatchingProgress			   = 1 << 0,
     NSMatchingCompleted			  = 1 << 1,
     NSMatchingHitEnd				 = 1 << 2,
     NSMatchingRequiredEnd			= 1 << 3,
     NSMatchingInternalError		  = 1 << 4
     };
     typedef NSUInteger NSMatchingFlags;
     */
}

@end
