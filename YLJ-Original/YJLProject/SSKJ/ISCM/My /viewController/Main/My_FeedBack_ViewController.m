//
//  My_FeedBack_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_FeedBack_ViewController.h"

@interface My_FeedBack_ViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *placeHloderLabel;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *phoneFiled;

@end

@implementation My_FeedBack_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"意见反馈", nil);
    [self setUI];
}


-(void)setUI
{
    [self.view addSubview:self.backView];
    
    [self.backView addSubview:self.textView];
    [self.textView addSubview:self.placeHloderLabel];
    
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneFiled];
    [self.view addSubview:self.submitButton];
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(105))];
        _backView.backgroundColor = kNavBGColor;
        _backView.layer.cornerRadius = ScaleW(3);
        _backView.clipsToBounds = YES;
    }
    return _backView;
}
-(UIView *)phoneView
{
    if (nil == _phoneView) {
        _phoneView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + _backView.bottom, ScreenWidth - ScaleW(30), ScaleW(50))];
        _phoneView.backgroundColor = kNavBGColor;
        _phoneView.layer.cornerRadius = ScaleW(3);
        _phoneView.clipsToBounds = YES;
    }
    return _phoneView;
}
-(UITextField *)phoneFiled{
    if (nil == _phoneFiled)
    {
        _phoneFiled = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(50))];
        _phoneFiled.textColor = kMainWihteColor;
        _phoneFiled.font = systemFont(ScaleW(14));
        _phoneFiled.placeholder =SSKJLocalized(@"留下您的联系方式", nil);
//         [_phoneFiled setValue:kSubTxtColor forKeyPath:@"_placeholderLabel.textColor"];
        
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"留下您的联系方式", nil) attributes:@{NSForegroundColorAttributeName :kSubTxtColor}];
        
        _phoneFiled.attributedPlaceholder = placeholderString1;
    }
    return _phoneFiled;
}
-(UITextView *)textView
{
    if (nil == _textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(120))];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = kMainWihteColor;
        _textView.font = systemFont(ScaleW(15));
        _textView.delegate = self;
    }
    return _textView;
}

-(UILabel *)placeHloderLabel
{
    if (nil == _placeHloderLabel) {
        _placeHloderLabel = [WLTools allocLabel:SSKJLocalized(@"请写下您的宝贵意见或建议", nil) font:systemFont(ScaleW(15)) textColor:kSubTxtColor frame:CGRectMake(0, ScaleW(5), self.textView.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _placeHloderLabel;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.phoneView.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _submitButton.backgroundColor = kTheMeColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - UITextFieldDelegate

-(void)textViewDidChange:(UITextView *)textView
{
//    CGFloat height = [textView.text boundingRectWithSize:CGSizeMake(self.textView.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textView.font} context:nil].size.height;
//
//    if (height <= ScaleW(30)) {
//        height = ScaleW(30);
//    }
//
//    self.textView.height = height + ScaleW(10);
//    self.backView.height = self.textView.bottom;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeHloderLabel.hidden = NO;
    }else{
        self.placeHloderLabel.hidden = YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHloderLabel.hidden = YES;
}


#pragma mark - 网络请求

-(void)submitEvent
{
    if (self.textView.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请写下您的宝贵意见或建议", nil)];
        return;
    }
    if (self.phoneFiled.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"留下您的联系方式", nil)];
        return;
    }
    
    [self requstCommit];
}
-(void)requstCommit
{
 
    WS(weakSelf);
    
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    //[pamas setObject:kuserUid forKey:@"iid"];
    
    //    [pamas setObject:@(self.currentType) forKey:@"lv"];
    [pamas setObject:self.textView.text forKey:@"des"];
    [pamas setObject:self.phoneFiled.text forKey:@"mobile"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_u_msg_Api RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
      
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        
        
        
        
        if (net_model.status.integerValue == 200) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    }];
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
