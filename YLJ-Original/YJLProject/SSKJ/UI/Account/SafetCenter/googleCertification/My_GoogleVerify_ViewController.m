//
//  My_GoogleVerify_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "My_Google_Model.h"
#import "RegularExpression.h"

@interface My_GoogleVerify_ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *warningLabel1;
@property (nonatomic, strong) UILabel *warningLabel2;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *bottomWarningLabel;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) My_BindGoogle_AlertView *alertView;

@property (nonatomic, strong) My_Google_Model *googleModel;


@end

@implementation My_GoogleVerify_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"绑定谷歌验证器", nil);
    
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self setUI];
    
    
    [self requestGoogle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
#pragma MARK - ui
-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.warningLabel1];
    [self.scrollView addSubview:self.warningLabel2];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.qrCodeImageView];
    [self.scrollView addSubview:self.codeLabel];
    [self.scrollView addSubview:self.bottomWarningLabel];
    [self.scrollView addSubview:self.nextButton];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.nextButton.bottom + ScaleW(20));
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,  ScaleW(10), ScreenWidth, ScreenHeight  - ScaleW(10))];
        _scrollView.backgroundColor = kSubBackgroundColor;
    }
    return _scrollView;
}

-(UILabel *)warningLabel1
{
    if (nil == _warningLabel1) {
        NSString *string = SSKJLocalized(@"打开谷歌验证器，扫描下方二维码或手动输入下述秘钥添加验证令牌。", nil);
        _warningLabel1 = [WLTools allocLabel:string font:systemFont(ScaleW(10.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(20), ScaleW(43), ScreenWidth - ScaleW(40), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
        _warningLabel1.numberOfLines = 0;
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_warningLabel1.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warningLabel1.font} context:nil].size.height;
        _warningLabel1.height = height;
    }
    return _warningLabel1;
}

-(UILabel *)warningLabel2
{
    if (nil == _warningLabel2) {
        NSString *string = SSKJLocalized(@"秘钥用户邮寄更换或遗失时找回谷歌验证器，绑定前请务必将下述秘钥备份保存", nil);

        _warningLabel2 = [WLTools allocLabel:string font:systemFont(ScaleW(10.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(20), self.warningLabel1.bottom + ScaleW(7), ScreenWidth - ScaleW(40), ScaleW(25)) textAlignment:NSTextAlignmentLeft];
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_warningLabel2.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warningLabel2.font} context:nil].size.height;
        _warningLabel2.height = height;
        _warningLabel2.numberOfLines = 0;

    }
    return _warningLabel2;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"请妥善备份秘钥以防遗失",nil) font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, self.warningLabel2.bottom + ScaleW(37), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(40), ScaleW(150), ScaleW(150))];
        _qrCodeImageView.centerX = self.view.width / 2;
        _qrCodeImageView.backgroundColor = [UIColor whiteColor];
    }
    return _qrCodeImageView;
}

-(UILabel *)codeLabel
{
    if (nil == _codeLabel) {
        _codeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTextLightBlueColor frame:CGRectMake(0, self.qrCodeImageView.bottom + ScaleW(39), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _codeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dumplcationEvent)];
        [_codeLabel addGestureRecognizer:tap];
    }
    return _codeLabel;
}

- (UILabel *)bottomWarningLabel
{
    if (nil == _bottomWarningLabel) {
        NSString *string = SSKJLocalized(@"保存二维码到手机或复制秘钥到剪切板可能会有安全风险，请妥善保存",nil);

        _bottomWarningLabel = [WLTools allocLabel:string font:systemFont(ScaleW(10.5)) textColor:kTextLightBlueColor frame:CGRectMake(ScaleW(20), self.codeLabel.bottom + ScaleW(55), ScreenWidth - ScaleW(40), ScaleW(25)) textAlignment:NSTextAlignmentLeft];
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_bottomWarningLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_bottomWarningLabel.font} context:nil].size.height;
        _bottomWarningLabel.height = height;
        _bottomWarningLabel.numberOfLines = 0;

    }
    return _bottomWarningLabel;
}

-(UIButton *)nextButton
{
    if (nil == _nextButton) {
        _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.bottomWarningLabel.bottom + ScaleW(88), ScreenWidth - ScaleW(50), ScaleW(45))];
        _nextButton.layer.cornerRadius = _nextButton.height / 2;
//        _nextButton.backgroundColor = kMainTextColor;
        [_nextButton setTitle:SSKJLocalized(@"下一步",nil) forState:UIControlStateNormal];
        [_nextButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = systemFont(ScaleW(16));
        [_nextButton addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton addGradientColor];
        _nextButton.layer.cornerRadius = ScaleW(5);
        _nextButton.layer.masksToBounds = YES;
    }
    return _nextButton;
}

-(My_BindGoogle_AlertView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _alertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestGoogleCommandWithCode:smsCode withGoogleCode:googleCode];
        };
    }
    return _alertView;
}

#pragma mark - 用户操作
// 下一步
-(void)nextEvent
{
    if (self.googleModel == nil) {
        [MBProgressHUD showError:@"数据异常"];
        return;
    }
    [self.alertView showWithType:GOOGLETYPEADD];
}

// 复制
-(void)dumplcationEvent
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.googleModel.command;
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功",nil)];
}


#pragma mark - 网络请求

-(void)requestGoogle
{
    NSDictionary *params = @{};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CreateGoogle_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            My_Google_Model *googleModel = [My_Google_Model mj_objectWithKeyValues:network_model.data];
            weakSelf.googleModel = googleModel;
            [weakSelf setViewWithGoogleModel:googleModel];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)requestGoogleCommandWithCode:(NSString *)code withGoogleCode:(NSString *)googleCode
{

    
    if (code.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }else if (googleCode.length == 0){
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    NSString *type;
    if ([RegularExpression validateMobile:kPhoneNumber]) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params = @{@"dyGoodleCommand":googleCode?:@"",
                             @"code":@(code.intValue),
                             @"type":type};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BingGoogle_State_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            if (weakSelf.addGoogleBlock) {
                weakSelf.addGoogleBlock();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)setViewWithGoogleModel:(My_Google_Model *)googleModel
{
    
    [self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:googleModel.local_url]]];
    
    self.codeLabel.text = [NSString stringWithFormat:@"%@  %@",googleModel.command,SSKJLocalized(@"复制", nil)];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.codeLabel.text];
    [attributeString addAttribute:NSForegroundColorAttributeName value:kMainTextColor range:NSMakeRange(attributeString.length - SSKJLocalized(@"复制", nil).length, SSKJLocalized(@"复制", nil).length)];
    self.codeLabel.attributedText = attributeString;
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
