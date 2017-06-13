//
//  MLDTicketViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDTicketViewController.h"
#import "MLDTicketDetailTableViewController.h"

@interface MLDTicketViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *pickerArray;
@property (weak, nonatomic) UITextField *from;
@property (weak, nonatomic) UITextField *destination;
@property (weak, nonatomic) UIButton *firstDate;
@property (weak, nonatomic) UIButton *secondDate;
@property (weak, nonatomic) UIButton *thirdDate;
@property (weak, nonatomic) UIButton *selBtn;
@property (weak, nonatomic) UIButton *searchBtn;
@property (weak, nonatomic) UIPickerView *pickView;
@property (weak, nonatomic) UITextField *currentTextField;

@end

@implementation MLDTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"单程机票";
    self.pickerArray = @[@"北京", @"上海", @"广州", @"深圳"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    [self setupUI];
}

- (void)shareItemClick:(UIButton *)shareBtn
{
    //机票页面分享时不需要获取mobid
    [[MLDTool shareInstance] shareWithMobId:nil
                                      title:@"快速查询机票信息"
                                       text:@"这是一个MobLink功能演示"
                                      image:@"jipiao_wxtj.png"
                                       path:@"/params/ticket"
                                     onView:shareBtn];
}

- (void)setupUI
{
    UIPickerView *pickView = [[UIPickerView alloc] init];
    self.pickView = pickView;
    pickView.dataSource = self;
    pickView.delegate = self;
    pickView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(doneItemClick)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(cancelItemClick)];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickView.frame.size.height - 40, SCREEN_WIDTH, 40)];
    toolBar.barStyle = UIBarStyleDefault;
    toolBar.items = @[cancelItem, flexItem, doneItem];
    
    UITextField *from = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, 125, 30)];
    self.from = from;
    from.placeholder = @"北京";
    from.delegate = self;
    from.textAlignment = NSTextAlignmentCenter;
    from.font = [UIFont systemFontOfSize:15];
    from.borderStyle = UITextBorderStyleNone;
    from.inputView = pickView;
    from.inputAccessoryView = toolBar;
    
    [self.view addSubview:from];
    
    UIView *fromLine = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(from.frame), 125, 0.5)];
    fromLine.backgroundColor = [MOBFColor colorWithRGB:0xD9D9D9];
    [self.view addSubview:fromLine];
    
    UILabel *flyLabel = [[UILabel alloc] init];
    flyLabel.text = @"飞往";
    flyLabel.textColor = [UIColor blackColor];
    flyLabel.font = [UIFont systemFontOfSize:17];
    [flyLabel sizeToFit];
    flyLabel.center = CGPointMake(self.view.center.x, from.center.y);
    
    [self.view addSubview:flyLabel];
    
    UITextField *destination = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 100, 125, 30)];
    self.destination = destination;
    destination.placeholder = @"上海";
    destination.delegate = self;
    destination.textAlignment = NSTextAlignmentCenter;
    destination.font = [UIFont systemFontOfSize:15];
    destination.borderStyle = UITextBorderStyleNone;
    destination.inputView = pickView;
    destination.inputAccessoryView = toolBar;
    
    [self.view addSubview:destination];
    
    UIView *toLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, CGRectGetMaxY(from.frame), 125, 0.5)];
    toLine.backgroundColor = [MOBFColor colorWithRGB:0xD9D9D9];
    [self.view addSubview:toLine];
    
    
    UIButton *firstDate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstDate = firstDate;
    self.selBtn = firstDate;
    firstDate.frame = CGRectMake(15, CGRectGetMaxY(fromLine.frame) + 45, 85, 30);
    [firstDate setTitle:@"1月3日" forState:UIControlStateNormal];
    [firstDate setTitleColor:[MOBFColor colorWithRGB:0x4B89EA] forState:UIControlStateNormal];
    firstDate.titleLabel.font = [UIFont systemFontOfSize:14];
    firstDate.layer.cornerRadius = 3.0;
    firstDate.layer.masksToBounds = YES;
    firstDate.layer.borderWidth = 0.5;
    //[MOBFColor colorWithRGB:0x4B89EA].CGColor
    firstDate.layer.borderColor = [MOBFColor colorWithRGB:0x4B89EA].CGColor;
    [firstDate addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:firstDate];
    
    UIButton *secondDate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondDate = secondDate;
    secondDate.bounds = CGRectMake(0, 0, 85, 30);
    secondDate.center = CGPointMake(self.view.center.x, firstDate.center.y);
    [secondDate setTitle:@"1月4日" forState:UIControlStateNormal];
    [secondDate setTitleColor:[MOBFColor colorWithRGB:0xa4a4a4] forState:UIControlStateNormal];
    secondDate.titleLabel.font = [UIFont systemFontOfSize:14];
    secondDate.layer.cornerRadius = 3.0;
    secondDate.layer.masksToBounds = YES;
    secondDate.layer.borderWidth = 0.5;
    secondDate.layer.borderColor = [MOBFColor colorWithRGB:0xD9D9D9].CGColor;
    [secondDate addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:secondDate];
    
    UIButton *thirdDate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdDate = thirdDate;
    thirdDate.frame = CGRectMake(SCREEN_WIDTH - 100, firstDate.frame.origin.y, 85, 30);
    [thirdDate setTitle:@"1月5日" forState:UIControlStateNormal];
    [thirdDate setTitleColor:[MOBFColor colorWithRGB:0xa4a4a4] forState:UIControlStateNormal];
    thirdDate.titleLabel.font = [UIFont systemFontOfSize:14];
    thirdDate.layer.cornerRadius = 3.0;
    thirdDate.layer.masksToBounds = YES;
    thirdDate.layer.borderWidth = 0.5;
    thirdDate.layer.borderColor = [MOBFColor colorWithRGB:0xD9D9D9].CGColor;
    [thirdDate addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:thirdDate];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.searchBtn = searchBtn;
    searchBtn.frame = CGRectMake(15, CGRectGetMaxY(secondDate.frame) + 60, SCREEN_WIDTH - 30, 40);
    searchBtn.backgroundColor = [MOBFColor colorWithRGB:0x4B89EA];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5.0;
    searchBtn.layer.masksToBounds = YES;
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchBtn];
}


- (void)dateBtnClick:(UIButton *)sender
{
    [self.selBtn setTitleColor:[MOBFColor colorWithRGB:0xa4a4a4] forState:UIControlStateNormal];
    self.selBtn.layer.borderColor = [MOBFColor colorWithRGB:0xD9D9D9].CGColor;
    
    [sender setTitleColor:[MOBFColor colorWithRGB:0x4B89EA] forState:UIControlStateNormal];
    sender.layer.borderColor = [MOBFColor colorWithRGB:0x4B89EA].CGColor;
    
    self.selBtn = sender;
}

- (void)searchBtnClick:(UIButton *)sender
{
    NSString *fromStr = self.from.text.length > 0 ? self.from.text : self.from.placeholder;
    NSString *toStr = self.destination.text.length > 0 ? self.destination.text : self.destination.placeholder;
    
    if ([fromStr isEqualToString:toStr])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"起飞和飞往城市不能一样，请重新选择。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        MLDTicketDetailTableViewController *ticketDetailCtr = [[MLDTicketDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
        ticketDetailCtr.date = self.selBtn.currentTitle;
        ticketDetailCtr.from = fromStr;
        ticketDetailCtr.to = toStr;
        [self.navigationController pushViewController:ticketDetailCtr animated:YES];
    }
}

- (void)doneItemClick
{
    [self.view endEditing:YES];
}

- (void)cancelItemClick
{
    [self.view endEditing:YES];
}

#pragma mark- TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
    if (textField == self.from)
    {
        textField.text = @"北京";
    }
    else if (textField == self.destination)
    {
        textField.text = @"上海";
    }
}


#pragma mark - Picker View Data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerArray[row];
}

#pragma mark- Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.currentTextField.text = self.pickerArray[row];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
