//
//  yanzViewController.m
//  倒计时
//
//  Created by slcf888 on 2017/12/15.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "yanzViewController.h"
#import "CapchaView.h"

@interface yanzViewController () <UITextFieldDelegate,UIAlertViewDelegate>
{
    CapchaView *_captchaView;
    UITextField *_input;
}

@end

@implementation yanzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xia)]];
    
    //显示验证界面
    _captchaView =[[CapchaView alloc]initWithFrame:CGRectMake(20, 40, 150, 40)];
    [self.view addSubview:_captchaView];
    //提示文字
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(190, 40, 100, 40)];
    label.text =@"点击图片换验证码";
    label.font =[UIFont systemFontOfSize:12];
    label.textColor =[UIColor grayColor];
    [self.view addSubview:label];
    //添加输入框
    _input =[[UITextField alloc]initWithFrame:CGRectMake(20, 100, 150, 40)];
    _input.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth =2.0;
    _input.layer.cornerRadius =5.0;
    _input.font =[UIFont systemFontOfSize:15];
    _input.placeholder =@"请输入验证码";
    _input.clearButtonMode =UITextFieldViewModeWhileEditing;
    _input.backgroundColor =[UIColor clearColor];
    _input.textAlignment =NSTextAlignmentCenter;
    _input.returnKeyType =UIReturnKeyDone;
    _input.delegate =self;
    [self.view addSubview:_input];
    
    // Do any additional setup after loading the view.
}
- (void)xia{
    [[UIApplication sharedApplication].keyWindow endEditing:YES] ;
}
#pragma 输入框协议店家return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片显示的验证码
    if ([[_input.text lowercaseString] isEqualToString:[_captchaView.changeString lowercaseString]]) {
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"Hello Word" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        //失败
        CAKeyframeAnimation *anim =[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount =1;
        anim.values =@[@-20,@20,@-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
    return YES;
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
