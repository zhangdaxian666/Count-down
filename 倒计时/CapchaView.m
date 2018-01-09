//
//  CapchaView.m
//  倒计时
//
//  Created by slcf888 on 2017/12/15.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "CapchaView.h"
#define kRandomColor [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 6
#define kLineWidth 1.0
#define kCharCount 6
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation CapchaView

@synthesize changeArray,changeString;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius =5.0; // 设置layer圆角半径
        self.layer.masksToBounds =YES; //隐藏边界
        self.backgroundColor =kRandomColor;
        // 显示一个随机验证码
        [self changeCaptcha];
    }
    return self;
}
- (void)changeCaptcha
{
    //1,从数组中随机抽组成字符串
    self.changeArray =[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];
    //changdu
    NSMutableString *getStr =[[NSMutableString alloc]initWithCapacity:kCharCount];
    self.changeString =[[NSMutableString alloc]initWithCapacity:kCharCount];
    //随机从数组选取字符
    for (int i=0; i<kCharCount; i++) {
        NSInteger index =arc4random()%([self.changeArray count]-1);
        getStr =[self.changeArray objectAtIndex:index];
        self.changeString =(NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
   //2，从网络获取
//    self.changeString =[NSMutableString stringWithFormat:@"杰瑞"];
}
#pragma 点击view时调用，当前自身就是uiview，点击更换验证码写方法，不添加手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击界面，切换验证码
    [self changeCaptcha];
    //setNeedsDisolay调用deawRect方法实现view的绘制
    [self setNeedsDisplay];
}
#pragma 绘制界面(1，UIView初始化后自动调用 2，调用setNwwsaDisplay时自动调用)
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor =kRandomColor;
    // 获取要现实的验证码，判断位置
    NSString *text =[NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize =[@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int width =rect.size.width/text.length -cSize.width;
    int height =rect.size.height -cSize.height;
    CGPoint point;
    
    //依次绘制每个字符，设置显示字符的字体大小，颜色样式
    float pX,pY;
    for (int i=0; i<text.length; i++) {
        pX =arc4random()%width +rect.size.width/text.length*i;
        pY =arc4random()%height;
        point =CGPointMake(pX, pY);
        unichar c =[text characterAtIndex:i];
        NSString *textC =[NSString stringWithFormat:@"%C",c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    //设置画线宽度
    CGContextSetLineWidth(context, kLineWidth);
    //绘制干扰的彩色直线
    for (int i=0; i<kLineCount; i++) {
        // 设置线的随机色
        UIColor *color =kRandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        // 设置起点
        pX =arc4random()%(int)rect.size.width;
        pY =arc4random()%(int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        // 设置终点
        pX =arc4random()%(int)rect.size.width;
        pY =arc4random()%(int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        // 画线
        CGContextStrokePath(context);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
