//
//  xiadanViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "xiadanViewController.h"
#import "SuperPayMoney_View.h"
@interface xiadanViewController ()
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIView *backView;

@end

@implementation xiadanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = kClearBackColor;
    
    [self.view addSubview:self.mainView];
    
    [self.mainView addSubview:self.titleLabel];
    
    [self.mainView addSubview:self.messageLabel];
    
    [self.mainView addSubview:self.conTextFild];
    
    [self.mainView addSubview:self.commitBtn];
    
    [self.view addSubview:self.backView];
}

-(UIView *)backView{
    
    if (nil == _backView) {
    
        _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.mainView.top)];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        [_backView addGestureRecognizer:tap];
        
    }
    
    return _backView;
    

}
-(void)tap:(UITapGestureRecognizer*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    if (self.cancelBlock) {
        
        self.cancelBlock();
        
    }
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(254), ScreenWidth , ScaleW(254))];
        _mainView.backgroundColor = kBgColor353750;
        
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"确认支付", nil) font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(16), _mainView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"价格：--" font:systemFont(ScaleW(13)) textColor:kSubSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(10) + _titleLabel.bottom, _mainView.width, ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _messageLabel;
}

-(UITextField *)conTextFild
{
    if (!_conTextFild) {
        _conTextFild = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(50) + _messageLabel.bottom+ScaleW(20), ScaleW(345), ScaleW(50))];
        [_conTextFild textField:_conTextFild textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"请输入安全密码", nil) textColor:kMainTextColor placeHolderTextColor:kSubSubTxtColor];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, _conTextFild.bottom+ScaleW(5), ScreenWidth , 1)];
        
        style.backgroundColor = kLineColor;
        
        style.alpha = 1;
        
        [self.mainView addSubview:style];
        
        
    }
    return _conTextFild;
}

-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainWihteColor text:SSKJLocalized(@"确定", nil) image:nil sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.titleLabel.font = systemBoldFont(ScaleW(16));
        _commitBtn.frame = CGRectMake(ScaleW(15), _conTextFild.bottom + ScaleW(50), ScaleW(345),ScaleW(53));
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];

        [_commitBtn setCornerRadius:ScaleW(5)];
        
        _commitBtn.backgroundColor = kTheMeColor ;
        
        
    }
    return _commitBtn;
}


-(void)commitBtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    !self.commitBlock?:self.commitBlock();
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
