//
//  CountDownViewController.m
//  倒计时
//
//  Created by slcf888 on 2017/12/15.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "CountDownViewController.h"
#import "yanzViewController.h"

@interface CountDownViewController ()
{
    NSInteger secondsCountDown; // 倒计时时长
    NSTimer *countDownTime;
}
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"倒计时展示";
    [self setBackBarButtonItenWithTitle:@"返回"];
    
    self.view.backgroundColor =[UIColor whiteColor];
    secondsCountDown = 3600;
    // 倒计时倒数时每秒调用一次
    countDownTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    //  设置倒计时显示时间
    NSString *str_hour =[NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    NSString *str_minute =[NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    NSString *str_second =[NSString stringWithFormat:@"%02ld",secondsCountDown%60];//秒
    
    NSString *format_time =[NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
//    NSLog(@"time:%@",format_time);
    
    self.timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.timeLabel.text =[NSString stringWithFormat:@"倒计时%@",format_time];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font =[UIFont systemFontOfSize:19];
    self.timeLabel.textColor =[UIColor redColor];
    [self.view addSubview:self.timeLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, self.view.frame.size.height-100-64, self.view.frame.size.width, 100);
    btn.backgroundColor =[UIColor purpleColor];
    [btn setTitle:@"跳转到验证码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(yan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)yan{
    yanzViewController *vc =[[yanzViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)countDownAction
{
    secondsCountDown--;
    NSString *str_hour =[NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    NSString *str_minute =[NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    NSString *str_second =[NSString stringWithFormat:@"%02ld",secondsCountDown%60];//秒
      NSString *format_time =[NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    //修改倒计时标签实现内容
    self.timeLabel.text =[NSString stringWithFormat:@"倒计时%@",format_time];
    //  当倒计时为0时
    if (secondsCountDown ==0) {
        [countDownTime invalidate]; //取消定时器
    }
}
//设置返回按钮标题
- (void)setBackBarButtonItenWithTitle:(NSString *)title
{
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setContentMode:UIViewContentModeScaleAspectFill];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 50)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem =barButtonItem;

}
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
