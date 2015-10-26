//
//  QLFrameParser.h
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLCoreTextData.h"
#import "QLFrameParserCfg.h"

@interface QLFrameParser : NSObject

+ (NSDictionary *)attributesWithConfig:(QLFrameParserCfg *)config;
+ (QLCoreTextData *)parseContent:(NSString *)content config:(QLFrameParserCfg*)config;

/** 用于提供对外的接口，调用方法二实现从一个 JSON 的模版文件中读取内容，然后调用方法五生成CoreTextData */
+ (QLCoreTextData *)parseTemplateFile:(NSString *)path config:(QLFrameParserCfg*)config;

/** 读取 JSON 文件内容，并且调用方法三获得从NSDictionary到NSAttributedString的转换结果。 */
+ (NSAttributedString *)loadTemplateFile:(NSString *)path config:(QLFrameParserCfg*)config imageArray:(NSMutableArray *)imageArray linkArray:(NSMutableArray *)linkArray;

/** NSDictionary内容转换为NSAttributedString */
+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict config:(QLFrameParserCfg*)config;

/** NSString转为UIColor的功能 */
+ (UIColor *)colorFromTemplate:(NSString *)name;

/** 接受一个NSAttributedString和一个config参数，将NSAttributedString转换成CoreTextData返回 */
+ (QLCoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(QLFrameParserCfg*)config;

@end
