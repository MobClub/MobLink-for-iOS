//
//  MLDShareView.m
//  MobLinkDemo
//
//  Created by lujh on 2018/6/19.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "MLDShareView.h"

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

static const CGFloat animationDuration = 0.35;

typedef void (^SVClickItemHandler) (NSInteger index);
typedef void (^SVDismissHandler) (void);
typedef void (^SVClickHandler) (NSInteger index);

@interface MLDShareView ()

@property (nonatomic, copy) SVClickItemHandler clickHandler;
@property (nonatomic, copy) SVDismissHandler dismissHandler;
@property (nonatomic, copy) SVClickHandler handler;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelBtn;

//计算view总高度
@property (nonatomic, assign) CGFloat shareBoxHeight;

//三个固定值
@property (nonatomic, assign) CGFloat shareBtnHeight;
@property (nonatomic, assign) CGFloat cancelBtnHeight;
@property (nonatomic, assign) CGFloat btnGap;

@end

@implementation MLDShareView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self configurationDefault];
    }
    return self;
}

- (void)configurationDefault
{
    self.btnGap = 10;
    self.shareBtnHeight = 45;
    self.cancelBtnHeight = 45;
    
    self.shareBtnColor = [UIColor whiteColor];
    self.cancelBtnBgColor = [UIColor whiteColor];
    
    self.cancelTitleColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1/1.0];
    self.itemTextColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1/1.0];
    self.itemFont = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    [window addSubview:self];
}


- (void)loadShareViewWithItemNameArray:(NSArray *)itemNameArray
                          ClickHandler:(void(^)(NSInteger index))handler
{
    self.handler = handler;
    self.itemNameArray = itemNameArray == nil ? self.itemNameArray : itemNameArray;
    
    [self layoutItems];
}

- (void)layoutItems
{
    NSInteger itemCount = self.itemNameArray.count;
    
    self.shareBoxHeight = self.shareBtnHeight * itemCount + self.cancelBtnHeight + 2 * self.btnGap;
    
    [self.itemNameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [shareBtn setTitle:obj forState:UIControlStateNormal];
        shareBtn.frame = CGRectMake(0, self.shareBtnHeight * idx, ScreenWidth - 2 * self.btnGap, self.shareBtnHeight);
        
        [shareBtn setBackgroundColor:self.shareBtnColor];
        [shareBtn setTitleColor:self.itemTextColor forState:UIControlStateNormal];
        shareBtn.titleLabel.font = self.itemFont;
        
        shareBtn.tag = idx;
        
        __weak typeof(self) weakSelf = self;
        
        self.clickHandler = ^(NSInteger index) {
            
            typeof(weakSelf) strongSelf = weakSelf;
            
            if (strongSelf.handler)
            {
                strongSelf.handler(index);
            }
        };
        
        [shareBtn addTarget:self action:@selector(clickedShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }];
    
    self.frame = CGRectMake(self.btnGap, ScreenHeight, ScreenWidth - 2 * self.btnGap, self.shareBoxHeight);
    
    self.cancelBtn.frame = CGRectMake(0, self.bounds.size.height - self.cancelBtnHeight - self.btnGap, ScreenWidth - 2 * self.btnGap, self.cancelBtnHeight);
}

- (void)clickedShareBtn:(UIButton *)btn
{
    [self dismissShareView];
    if (self.clickHandler)
    {
        self.clickHandler(btn.tag);
    }
}

- (void)showShareView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         weakSelf.bgView.hidden = NO;
                         weakSelf.frame = CGRectMake(self.btnGap, ScreenHeight - weakSelf.shareBoxHeight, ScreenWidth - 2 * self.btnGap, weakSelf.shareBoxHeight);
                     } completion:nil];
}

- (void)dismissShareView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         weakSelf.bgView.hidden = YES;
                         weakSelf.frame = CGRectMake(self.btnGap, ScreenHeight, ScreenWidth - 2 * self.btnGap, weakSelf.shareBoxHeight);
                     } completion:^(BOOL finished) {
                         
                         if (weakSelf.dismissHandler)
                         {
                             weakSelf.dismissHandler();
                         }
                     }];
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.backgroundColor = self.cancelBtnBgColor;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:self.cancelTitleColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = self.itemFont;
        
        __weak typeof(self) weakSelf = self;
        self.dismissHandler = ^{
            
            typeof(weakSelf) strongSelf = weakSelf;
            
            if (strongSelf.handler)
            {
                strongSelf.handler(-1);
            }
        };
        [_cancelBtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)dealloc
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}


@end
