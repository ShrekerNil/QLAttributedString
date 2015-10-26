//
//  QLEmotionView.m
//  Demo_QLExpression
//
//  Created by 闫庆龙 on 15/4/26.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLEmotionView.h"
#import "QLEmotionPageView.h"

const NSUInteger QLEmotionViewPageSize = 20;

@interface QLEmotionView () <UIScrollViewDelegate>
{
    __weak UIScrollView *_scrollView;
    __weak UIPageControl *_pageCtrl;
}

@end

@implementation QLEmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    UIPageControl *pageCtrl = [[UIPageControl alloc] init];
    [pageCtrl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
    [pageCtrl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
    pageCtrl.userInteractionEnabled = NO;
    [self addSubview:pageCtrl];
    _pageCtrl = pageCtrl;
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize sizeSelf = self.frame.size;
    
    CGFloat fHeightPageCtrl = 30;
    CGRect rectPageCtrl = CGRectMake(0, sizeSelf.height - fHeightPageCtrl, sizeSelf.width, fHeightPageCtrl);
    [_pageCtrl setFrame:rectPageCtrl];
    
    CGRect rectScrollView = CGRectMake(0, 0, sizeSelf.width, sizeSelf.height-fHeightPageCtrl);
    [_scrollView setFrame:rectScrollView];
    
    // 设置页数
    _scrollView.contentSize = CGSizeMake(sizeSelf.width * _pageCtrl.numberOfPages, 1);
    
    // 设置pageView的尺寸
    NSUInteger count = _scrollView.subviews.count;
    for (NSUInteger index = 0; index < count; index ++) {
        QLEmotionPageView *view = _scrollView.subviews[index];
        if ([view isKindOfClass:[UIImageView class]]) continue;
        CGRect rectViewPage = CGRectMake(index * sizeSelf.width, 0, sizeSelf.width, sizeSelf.height-fHeightPageCtrl);
        view.frame = rectViewPage;
    }
}

- (void)setArrEmotions:(NSArray *)arrEmotions {
    _arrEmotions = arrEmotions;
    NSUInteger countEmotions = arrEmotions.count;
    NSUInteger countPages = (countEmotions + QLEmotionViewPageSize - 1)/QLEmotionViewPageSize;
    _pageCtrl.numberOfPages = countPages;
    for (NSUInteger index = 0; index < countPages; index ++) {
        QLEmotionPageView *viewPage = [[QLEmotionPageView alloc] init];
        NSRange rangeEmotions;
        rangeEmotions.location = index * QLEmotionViewPageSize;
        NSUInteger delta = countEmotions - rangeEmotions.location;
        rangeEmotions.length = delta >= QLEmotionViewPageSize ? QLEmotionViewPageSize : delta;
        viewPage.arrEmotions = [arrEmotions subarrayWithRange:rangeEmotions];
        [_scrollView addSubview:viewPage];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageCtrl.currentPage = (NSInteger)(currentPage + 0.5);
}

@end
