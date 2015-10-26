//
//  QLEmotionModel.h
//  QLEmotion
//
//  Created by Shrek on 15/5/12.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLEmotionModel : NSObject

/** 其他 */
@property (nonatomic, copy) NSString *chs;
@property (nonatomic, copy) NSString *png;

/** Emoji */
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy, readonly) NSString *emoji;

- (instancetype)initWithDictionary:(NSDictionary *)dicData;

@end
