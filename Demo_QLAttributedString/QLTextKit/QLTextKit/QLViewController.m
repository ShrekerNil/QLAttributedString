//
//  QLViewController.m
//  QLTextKit
//
//  Created by Shrek on 15/8/18.
//  Copyright (c) 2015年 M. All rights reserved.
//

#import "QLViewController.h"
#import "QLTextView.h"
#import "QLFrameParser.h"
#import "QLFrameParserCfg.h"
#import "QLCoreTextData.h"
#import "QLCoreTextImage.h"
#import "QLCoreTextLink.h"
#import "UIView+QLViewForFrame.h"
#import "ImageViewController.h"
#import "WebContentViewController.h"

@interface QLViewController ()
{
    __weak IBOutlet QLTextView *_viewTest;
}

@end

@implementation QLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testLink];
}

- (void)testLink {
    QLFrameParserCfg *config = [[QLFrameParserCfg alloc] init];
    config.width = _viewTest.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_link" ofType:@"json"];
    QLCoreTextData *data = [QLFrameParser parseTemplateFile:path config:config];
    _viewTest.data = data;
    _viewTest.height = data.height;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:) name:QLTextViewImageTapedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:) name:QLTextViewLinkTapedNotification object:nil];
}

- (void)testImage {
    QLFrameParserCfg *config = [[QLFrameParserCfg alloc] init];
    config.width = _viewTest.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_img" ofType:@"json"];
    QLCoreTextData *data = [QLFrameParser parseTemplateFile:path config:config];
    _viewTest.data = data;
    _viewTest.height = data.height;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:) name:QLTextViewImageTapedNotification object:nil];
}

- (void)testAttributedText {
    QLFrameParserCfg *config = [[QLFrameParserCfg alloc] init];
    config.width = _viewTest.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content.json" ofType:nil];
    QLCoreTextData *data = [QLFrameParser parseTemplateFile:path config:config];
    _viewTest.data = data;
    _viewTest.height = data.height;
}

- (void)testPlainText {
    QLFrameParserCfg *config = [[QLFrameParserCfg alloc] init];
    config.width = _viewTest.width;
    config.textColor = [UIColor blackColor];
    
    NSString *content = @"对于上面的例子，我们给 CTFrameParser 增加了一个将 NSString 转换为 CoreTextData 的方法。但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体大小，颜色，行高等信息，但是却不能支持定制内容中的某一部分。例如，如果我们只想让内容的前三个字显示成红色，而其它文字显示成黑色，那么就办不到了。NSAttributeString 作为参数，然后在 NSAttributeString 中设置好我们想要的信息。";
    NSDictionary *attr = [QLFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
    
    QLCoreTextData *data = [QLFrameParser parseAttributedContent:attributedString config:config];
    _viewTest.data = data;
    _viewTest.height = data.height;
}

- (void)test {
    QLFrameParserCfg *config = [[QLFrameParserCfg alloc] init];
    config.textColor = [UIColor redColor];
    config.width = 150;
    
    QLCoreTextData *data = [QLFrameParser parseContent:@" 按照以上原则，我们将`CTDisplayView`中的部分内容拆开。" config:config];
    _viewTest.data = data;
    _viewTest.height = data.height;
    _viewTest.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Actions
- (void)imagePressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    QLCoreTextImage *imageData = userInfo[@"imageData"];
    
    ImageViewController *vc = [[ImageViewController alloc] init];
    vc.image = [UIImage imageNamed:imageData.name];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    QLCoreTextLink *linkData = userInfo[@"linkData"];
    
    WebContentViewController *vc = [[WebContentViewController alloc] init];
    vc.urlTitle = linkData.title;
    vc.url = linkData.url;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
