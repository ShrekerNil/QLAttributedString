//
//  QLCoreTextImage.h
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLCoreTextImage : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSUInteger position;

// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic) CGRect imagePosition;

@end
