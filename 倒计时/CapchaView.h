//
//  CapchaView.h
//  倒计时
//
//  Created by slcf888 on 2017/12/15.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapchaView : UIView

@property (nonatomic, retain) NSArray *changeArray;  //字符数组
@property (nonatomic, retain) NSMutableString *changeString; //验证码的字符串

@end
