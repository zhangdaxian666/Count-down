//
//  ViewController.m
//  倒计时
//
//  Created by slcf888 on 2017/12/14.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "ViewController.h"
#import "CountDownViewController.h"

@interface ViewController ()
{
    int _count;
    UILabel *_label;
    
    UIButton *btn;
    int timeDown;
    NSTimer *timer;
    
    
    UIButton *_getNumBtn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"倒计时";
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor redColor]}];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideContainerView)];
    [self.view addGestureRecognizer:tap];
    
//    [self performSelectorInBackground:@selector(thread) withObject:nil];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 120, 40)];
    _label.backgroundColor =[UIColor orangeColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:30];
    _label.text = @"60";
//   [_label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideContainerView)]];
    [self.view addSubview:_label];
   
    
    btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(10, 200, 300, 50);
    btn.backgroundColor =[UIColor cyanColor];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _getNumBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _getNumBtn.frame =CGRectMake(10, 400, 300, 50);
    _getNumBtn.backgroundColor =[UIColor cyanColor];
    [_getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getNumBtn addTarget:self action:@selector(getNumBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getNumBtn];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)hideContainerView
{
    CountDownViewController *vc =[[CountDownViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)thread{
    for (int i =59; i>=0; i--) {
        _count = i;
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
        sleep(1);
    }
}
- (void)mainThread
{
    _label.text =[NSString stringWithFormat:@"%d",_count];
    if (_count ==0) {
        
    }
}

/////////
- (void)btnAction
{
    timeDown =59;
    [self handleTime];
    timer =[NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTime) userInfo:nil repeats:YES];
}
- (void)handleTime
{
    if (timeDown >=0) {
        [btn setUserInteractionEnabled:YES];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        int sec =((timeDown%(24*3600))%3600)%60;
        [btn setTitle:[NSString stringWithFormat:@"(%d)重发验证码",sec] forState:UIControlStateNormal];
    }else{
        [btn setUserInteractionEnabled:YES];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"重发验证码" forState:UIControlStateNormal];
        
        [timer invalidate];
    }
    timeDown =timeDown -1; //每次减少的数。上面是秒数
}




////////////
- (void)getNumBtnAction
{
    //全剧队列 默认优先级
    __block NSInteger second = 60;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    定时器模式 事件源
    dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
//    NSEC_PER_SEC是秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC *1, 0);
//    设置相应事件的block
    dispatch_source_set_event_handler(timer, ^{
//        回调住线程
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >=0) {
                [_getNumBtn setTitle:[NSString stringWithFormat:@"(%ld)重发验证码",second] forState:UIControlStateNormal];
                second--;
            }else{
//                要写否则出问题
                dispatch_source_cancel(timer);
                [_getNumBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
            }
        });
    });
//    启动源
    dispatch_resume(timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// http://blog.csdn.net/codingfire/article/details/52329856
@end
