//
//  ViewController.m
//  QLExpressionLabel
//
//  Created by Shrek on 14/12/22.
//  Copyright (c) 2014年 Shrek. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

#import "QLExpressionLabel.h"
#import "QLExpressionTextView.h"
#import "QLExpressionString.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //[self labelTest];
    //[self textFieldTest];
    //[self labelString];
}

- (void)textFieldTest {
    QLExpressionTextView *textView = [[QLExpressionTextView alloc] initWithFrame:CGRectMake(10, 200, 300, 100)];
    [textView.layer setBorderColor:[UIColor orangeColor].CGColor];
    [textView.layer setBorderWidth:0.5f];
    [textView setFont:[UIFont systemFontOfSize:15]];
    [textView.layer setMasksToBounds:YES];
    [self.view addSubview:textView];
}

- (void)labelTest {
    QLExpressionLabel *label = [[QLExpressionLabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:15]];
    NSString *strExpression = @"换个v烦烦烦烦烦烦/em0010/em0009/em0013/em0014/em0014/em0014/em0018/em0018";
    [label setStrContentWithExpression:strExpression];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //NSString *strTemp = [strExpression stringByReplacingOccurrencesOfString:@"/em" withString:@"  "];
    
    CGSize sizeLabel = [strExpression boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    CGRect rectLabel = (CGRect){10, 100, sizeLabel};
    [label setFrame:rectLabel];
    
    
    //NSUInteger countExpression = label.countExpression;
    
    
    [label setBackgroundColor:[UIColor orangeColor]];
    
    [self.view addSubview:label];
}

- (void)labelString {
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor whiteColor]];
    
    QLExpressionString *strExpression = [QLExpressionString expressionStringWithString:@"换个v烦烦烦烦烦烦/em0010/em0009爱哭鬼/em0013/em0014/em0014/em0014/em0018啊水电费噶色排骨饭/em0018"];
    [label setAttributedText:strExpression];
    [label setFont:[UIFont systemFontOfSize:15]];
    
    //CGSize size = [strExpression boundingRectWithSize:CGSizeMake(300, 500) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [label setFrame:(CGRect){10, 100, 300, 100}];
    [label setNumberOfLines:0];
    
    [self.view addSubview:label];
}

- (int)getAttributedStringHeightWithString:(NSAttributedString *)  string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
