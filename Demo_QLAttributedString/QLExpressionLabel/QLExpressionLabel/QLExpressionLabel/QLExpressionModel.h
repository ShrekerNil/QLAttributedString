//
//  QLExpressionModel.h
//  QLExpressionLabel
//
//  Created by Shrek on 15/1/18.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLExpressionModel : NSObject

@property (nonatomic, copy) NSString *strContentName;
@property (nonatomic, copy) NSString *strImageName;
@property (nonatomic, copy) NSString *strId;

- (instancetype)initWithDictionary:(NSDictionary *)dicData;

@end
