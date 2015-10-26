//
//  QLEmotionModel.m
//  QLEmotion
//
//  Created by Shrek on 15/5/12.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLEmotionModel.h"
#import "NSString+Emoji.h"

@implementation QLEmotionModel

- (instancetype)initWithDictionary:(NSDictionary *)dicData {
    if (self = [super init]) {
        _chs = dicData[@"chs"];
        _png = dicData[@"png"];
        _code = dicData[@"code"];
        _emoji = [_code emoji];
    }
    return self;
}

@end
