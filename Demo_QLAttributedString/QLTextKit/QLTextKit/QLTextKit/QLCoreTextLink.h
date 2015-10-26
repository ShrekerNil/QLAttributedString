//
//  QLCoreTextLink.h
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@class QLCoreTextData;

@interface QLCoreTextLink : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) NSRange range;

+ (QLCoreTextLink *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(QLCoreTextData *)data;

@end
