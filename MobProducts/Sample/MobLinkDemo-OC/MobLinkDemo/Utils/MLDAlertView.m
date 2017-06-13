//
//  MLDAlertView.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDAlertView.h"

#define AlertView_W     (SCREEN_WIDTH - 60)
#define AlertTitle_H    44.0f
#define AlertText_H     150.0f
#define AlertBtn_H      40.0f

@interface MLDAlertView()

@property (copy, nonatomic) MLDAlertClickButtonBlock block;
@property (weak, nonatomic) UIView *alertView;
@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) UILabel *msgLabel;
@property (weak, nonatomic) UIButton *cancelBtn;
@property (weak, nonatomic) UIButton *otherBtn;
@property (strong, nonatomic) UIWindow *alertWindow;

@end

@implementation MLDAlertView

/**
 初始化方法
 
 @param title 提示框标题
 @param message 提示内容
 @param cancelTitle 取消按钮标题
 @param otherBtnTitle 其他按钮标题(目前仅支持2个按钮)
 @param block 按钮点击回调
 @param type 展示内容所用的控件类型
 @return alertView对象
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
               cancelBtnTitle:(NSString *)cancelTitle
                otherBtnTitle:(NSString *)otherBtnTitle
                   clickBlock:(MLDAlertClickButtonBlock)block
                         type:(MLDShowContentType)type
{
    if (self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
        
        self.block = block;
        
        UIView *alertView = [[UIView alloc] init];
        self.alertView = alertView;
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.layer.cornerRadius = 6.0;
        alertView.layer.masksToBounds = YES;
        alertView.userInteractionEnabled = YES;
        
        // title
        if (title)
        {
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, AlertView_W, AlertTitle_H)];
            self.titleLab = titleLab;
            titleLab.text = title;
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.textColor = [UIColor blackColor];
            titleLab.font = [UIFont boldSystemFontOfSize:15];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame), AlertView_W - 20, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            
            [alertView addSubview:titleLab];
            [alertView addSubview:line];
        }
        
        // message
        if (message)
        {
            if (type == MLDShowContentTypeLabel)
            {
                UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLab.frame) + 0.5, AlertView_W, 60)];
                self.msgLabel = msgLabel;
                msgLabel.text = message;
                msgLabel.font = [UIFont systemFontOfSize:15];
                msgLabel.numberOfLines = 0;
                msgLabel.textAlignment = NSTextAlignmentCenter;
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(msgLabel.frame), AlertView_W, 0.5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [alertView addSubview:msgLabel];
                [alertView addSubview:line];
            }
            else
            {
                UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLab.frame) + 0.5, AlertView_W, AlertText_H)];
                self.textView = textView;
                textView.editable = NO;
                textView.textAlignment = NSTextAlignmentLeft;
                textView.text = message;
                textView.font = [UIFont systemFontOfSize:15];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame), AlertView_W, 0.5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [alertView addSubview:textView];
                [alertView addSubview:line];
            }
        }
        
        // cancelBtn
        if (cancelTitle) {
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelBtn = cancelBtn;
            [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            cancelBtn.layer.cornerRadius = 5.0;
            cancelBtn.layer.masksToBounds = YES;
            [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [alertView addSubview:cancelBtn];
        }
        
        // otherBtn
        if (otherBtnTitle)
        {
            UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.otherBtn = otherBtn;
            [otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            otherBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            otherBtn.layer.cornerRadius = 5.0;
            otherBtn.layer.masksToBounds = YES;
            [otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [alertView addSubview:otherBtn];
        }
        
        CGFloat btnH = self.textView ? CGRectGetMaxY(self.textView.frame) + 5.0 : CGRectGetMaxY(self.msgLabel.frame) + 5.0;
        
        if (cancelTitle && !otherBtnTitle)
        {
            // 只有取消按钮
            self.cancelBtn.tag = 1121;
            self.cancelBtn.frame = CGRectMake(10, btnH, AlertView_W - 20, AlertBtn_H);
        }
        else if (!cancelTitle && otherBtnTitle)
        {
            // 只有确定按钮
            self.otherBtn.tag = 1122;
            self.otherBtn.frame = CGRectMake(10, btnH, AlertView_W - 20, AlertBtn_H);
        }
        else if (cancelTitle && otherBtnTitle)
        {
            // 两个按钮都有
            self.cancelBtn.tag = 1121;
            self.otherBtn.tag = 1122;
            
            self.cancelBtn.frame = CGRectMake(10, btnH, AlertView_W / 2.0 - 15, AlertBtn_H);
            self.otherBtn.frame = CGRectMake(AlertView_W / 2.0 + 5, btnH, AlertView_W / 2.0 - 15, AlertBtn_H);
            // 两个按钮之间的分割线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AlertView_W / 2.0, btnH, 0.5, AlertBtn_H)];
            line.backgroundColor = [UIColor lightGrayColor];
            [alertView addSubview:line];
        }
        
        // 计算alertView的大小
        CGFloat alertH = cancelTitle == nil ? CGRectGetMaxY(self.otherBtn.frame) + 5.0 : CGRectGetMaxY(self.cancelBtn.frame) + 5.0;
        alertView.bounds = CGRectMake(0, 0, AlertView_W, alertH);
        alertView.center = self.center;
        [self addSubview:alertView];
        
    }
    return self;
}

/**
 显示alertView,使用默认动画
 */
- (void)show
{
    [self showWithAnimationStyle:MLDShowAnimationDefault];
}

/**
 关闭alertView
 */
- (void)dismiss
{
    [_alertWindow resignKeyWindow];
    [self removeFromSuperview];
}


#pragma mark - Private

/**
 按钮点击方法

 @param btn 按钮
 */
- (void)btnClick:(UIButton *)btn
{
    if (self.block) {
        btn.tag == 1121 ? self.block(MLDButtonTypeCancel) : self.block(MLDButtonTypeSure);
    }
    
    [self dismiss];
}


/**
 动画显示AlertView

 @param style 动画方式
 */
- (void)showWithAnimationStyle:(MLDShowAnimationStyle)style
{
    _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _alertWindow.windowLevel = UIWindowLevelAlert;
    [_alertWindow makeKeyAndVisible];
    
    [_alertWindow addSubview:self];
    
    switch (style)
    {
        case MLDShowAnimationDefault:
        {
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.alertView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.12 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [self.alertView.layer setValue:@(0.9) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [self.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
            break;
        }
        
        case MLDShowAnimationLeftShake:
        {
            CGPoint startPoint = CGPointMake(-AlertView_W, self.center.y);
            self.alertView.layer.position = startPoint;
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                self.alertView.layer.position = self.center;
                
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
        
        case MLDShowAnimationTopShake:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position = startPoint;
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.alertView.layer.position = self.center;
                
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
        
        default:
            break;
    }
}

@end
