//
//  QLExpressionModel.m
//  QLExpressionLabel
//
//  Created by Shrek on 15/1/18.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLExpressionModel.h"

@implementation QLExpressionModel

- (instancetype)initWithDictionary:(NSDictionary *)dicData {
    if (self = [super init]) {
        _strContentName = dicData[@"contentName"];
        _strImageName = dicData[@"imageName"];
        _strId = dicData[@"id"];
    }
    return self;
}

@end
