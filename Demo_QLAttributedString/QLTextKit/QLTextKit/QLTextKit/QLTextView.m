//
//  QLTextView.m
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLTextView.h"
#import <CoreText/CoreText.h>
#import "QLCoreTextImage.h"
#import "QLCoreTextLink.h"

NSString * const QLTextViewImageTapedNotification = @"QLTextViewImagePressedNotification";
NSString * const QLTextViewLinkTapedNotification = @"QLTextViewLinkPressedNotification";

@interface QLTextView ()

@end

@implementation QLTextView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
    
    for (QLCoreTextImage *imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self loadDefaultSetting];
    }
    return self;
}

#pragma mark - Load default UI and Data
- (void)loadDefaultSetting {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    self.userInteractionEnabled = YES;
}

#pragma mark - Actions
- (void)tapAction:(UITapGestureRecognizer *)grTap {
    CGPoint point = [grTap locationInView:self];
    for (QLCoreTextImage *imageData in self.data.imageArray) {
        // 翻转坐标系，因为 imageData 中的坐标是 CoreText 的坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y
        - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        // 检测点击位置 Point 是否在 rect 之内
        if (CGRectContainsPoint(rect, point)) {
            // 在这里处理点击后的逻辑
            NSDictionary *userInfo = @{@"imageData": imageData};
            [[NSNotificationCenter defaultCenter] postNotificationName:QLTextViewImageTapedNotification object:self userInfo:userInfo];
            break;
        }
    }
    
    QLCoreTextLink *linkData = [QLCoreTextLink touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        NSDictionary *userInfo = @{ @"linkData": linkData };
        [[NSNotificationCenter defaultCenter] postNotificationName:QLTextViewLinkTapedNotification object:self userInfo:userInfo];
        return;
    }
}

@end
