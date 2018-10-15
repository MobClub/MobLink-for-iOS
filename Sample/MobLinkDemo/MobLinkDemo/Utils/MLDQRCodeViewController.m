//
//  MLDQRCodeViewController.m
//  MobLinkDemo
//
//  Created by lujh on 2018/6/19.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "MLDQRCodeViewController.h"
#import "UIImage+MLDQRCode.h"

@interface MLDQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@end

@implementation MLDQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.contentScrollView.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    
    self.title = @"分享二维码";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    UIImage *image = [UIImage mldCreateQRCodeImageFormString:self.url withSize:self.qrCodeImageView.bounds.size.width];
    
    self.qrCodeImageView.image = image;
}

- (UIImage *)captureScrollView:(UIScrollView *)scrollView
{
    UIImage *image = nil;
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();

    return image;
}

- (void)shareItemClick:(UIButton *)shareBtn
{
    UIImage *image = [self captureScrollView:self.contentScrollView];
    
    [[MLDTool shareInstance] shareQRCodeImage:image
                                         text:@"分享二维码"
                                        title:@"分享二维码"
                                       onView:shareBtn];
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
