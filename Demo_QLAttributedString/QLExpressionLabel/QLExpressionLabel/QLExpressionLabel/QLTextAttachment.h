//
//  QLTextAttachment.h
//  QLExpressionLabel
//
//  Created by Shrek on 14/12/23.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLExpressionModel.h"

@interface QLTextAttachment : NSTextAttachment

@property (nonatomic, strong) QLExpressionModel *expressionModel;

@end
