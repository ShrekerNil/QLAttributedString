//
//  QLFrameParserCfg.m
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLFrameParserCfg.h"
#import "QLConst.h"

@implementation QLFrameParserCfg

- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = QLColorWithRGB(108, 108, 108);
    }
    return self;
}

@end
