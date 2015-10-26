//
//  QLViewController.m
//  Test
//
//  Created by Shrek on 15/5/12.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "QLViewController.h"

#import "QLEmotionKeyBoard.h"
#import "QLAccessoryToolBar.h"
#import "QLEmotionTextView.h"

@interface QLViewController ()
{
    __weak IBOutlet QLEmotionTextView *_textView;
    QLAccessoryToolBar *_accessoryToolBar;
}

@property (nonatomic, strong) QLEmotionKeyBoard *keyBoard;

@end

@implementation QLViewController

- (QLEmotionKeyBoard *)keyBoard {
    if (!_keyBoard) {
        _keyBoard = [[QLEmotionKeyBoard alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    }
    return _keyBoard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.placeholder = @"输入一些文字吧";
    
    QLAccessoryToolBar *accessoryToolBar = [[QLAccessoryToolBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    __weak typeof(self) selfWeak = self;
    [accessoryToolBar setBlkDidSelectEmotionButton:^(UIButton *button) {
        [selfWeak exchangeKeyboardWithButton:button];
    }];
    _textView.inputAccessoryView = accessoryToolBar;
    _accessoryToolBar = accessoryToolBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectEmotion:) name:QLEmotionDidSelectEmotionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDeleteEmotion) name:QLEmotionDidDeleteEmotionNotification object:nil];
}

- (void)didSelectEmotion:(NSNotification *)notification {
    QLEmotionModel *emotionModel = notification.userInfo[QLEmotionSelectEmotionKey];
    [_textView insertEmotion:emotionModel];
}
- (void)didDeleteEmotion {
    [_textView deleteBackward];
}

- (void)exchangeKeyboardWithButton:(UIButton *)button {
    if (_textView.inputView == nil) { // 切换到表情键盘
        _textView.inputView = self.keyBoard;
        _accessoryToolBar.shouldShowSystemIcon = YES;
    } else { // 切换到系统键盘
        _textView.inputView = nil;
        _accessoryToolBar.shouldShowSystemIcon = NO;
    }
    
    [_textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_textView becomeFirstResponder];
    });
}

- (IBAction)getText:(UIBarButtonItem *)sender {
    QLLog(@"%@", [_textView descriptionText]);
}

@end
