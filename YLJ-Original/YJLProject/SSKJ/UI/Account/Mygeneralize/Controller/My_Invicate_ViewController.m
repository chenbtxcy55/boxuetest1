//
//  My_Invicate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/25.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Invicate_ViewController.h"
#import "HeBi_Default_AlertView.h"
@interface My_Invicate_ViewController ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIView *qrCodeBackView;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *saveTitleLabel;

@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UIButton *dumplicationButton;
@property (nonatomic, strong) UIImageView *qrBGIM;

@end

@implementation My_Invicate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"我要推广", nil);
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self requestInvicate];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)setUI
{
    [self.view addSubview:self.backImageView];
    [self.backImageView addSubview:self.qrBGIM];
    [self.qrBGIM addSubview:self.qrCodeBackView];
    [self.qrCodeBackView addSubview:self.qrCodeImageView];
    [self.qrBGIM addSubview:self.saveTitleLabel];
    
    [self.qrBGIM addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeLabel];
    [self.codeBackView addSubview:self.dumplicationButton];
}

- (UIImageView *)qrBGIM {
    if (!_qrBGIM) {
        _qrBGIM = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScreenHeight-Height_NavBar-ScaleW(294)-ScaleW(10), ScreenWidth-ScaleW(20), ScaleW(294))];
        _qrBGIM.image = [UIImage imageNamed:@"sc-bg-img"];
        _qrBGIM.userInteractionEnabled = YES;
    }
    return _qrBGIM;

}
-(UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _backImageView.image = [UIImage imageNamed:SSKJLocalized(@"Mine_tuiguang-kh", nil)];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

-(UIView *)qrCodeBackView
{
    if (nil == _qrCodeBackView) {
        
        CGFloat height = ScaleW(40);
//        if (IS_IPhoneX_All) {
//            height = ScaleW(400);
//        }
        
        _qrCodeBackView = [[UIView alloc]initWithFrame:CGRectMake(0, height, ScaleW(87), ScaleW(87))];
        _qrCodeBackView.centerX = ScreenWidth / 2;
        _qrCodeBackView.backgroundColor = kMainWihteColor;
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
        [_qrCodeBackView addGestureRecognizer:tap];
        
    }
    return _qrCodeBackView;
}

-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(6), ScaleW(6), self.qrCodeBackView.width - ScaleW(12), self.qrCodeBackView.height - ScaleW(12))];
    }
    return _qrCodeImageView;
}


- (UILabel *)saveTitleLabel
{
    
    if (nil == _saveTitleLabel) {
        _saveTitleLabel = [WLTools allocLabel:SSKJLocalized(@"长按保存二维码", nil) font:systemFont(ScaleW(12)) textColor:kTextLightBlueColor frame:CGRectMake(0, self.qrCodeBackView.bottom + ScaleW(17), ScreenWidth, ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _saveTitleLabel;
}

-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(34), self.saveTitleLabel.bottom  + ScaleW(31), ScreenWidth - ScaleW(68)-ScaleW(20), ScaleW(70))];
        _codeBackView.backgroundColor = RGBACOLOR(135, 143, 245, 0.2);
    }
    return _codeBackView;
}

-(UILabel *)codeLabel
{
    if (nil == _codeLabel) {
        _codeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTextLightBlueColor frame:CGRectMake(0, ScaleW(15), self.codeBackView.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _codeLabel;
}

-(UIButton *)dumplicationButton
{
    if (nil == _dumplicationButton) {
        _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.codeLabel.bottom, self.codeBackView.width, self.codeBackView.height - self.codeLabel.bottom)];
        [_dumplicationButton setTitle:SSKJLocalized(@"复制", nil) forState:UIControlStateNormal];
        [_dumplicationButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _dumplicationButton.titleLabel.font = systemFont(ScaleW(14));
        [_dumplicationButton addTarget:self action:@selector(copyEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dumplicationButton;
}


-(void)saveImage:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        WS(weakSelf);
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"保存二维码", nil)  message:SSKJLocalized(@"保存二维码到相册", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"保存", nil) confirmBlock:^{
            UIImage *img = weakSelf.qrCodeImageView.image;
            UIImageWriteToSavedPhotosAlbum(img, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }];
    }
}

// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
}


-(void)copyEvent
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.codeLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
}

-(void)requestInvicate
{
    NSDictionary *params = @{};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_MyHome_Link_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:network_model.data[@"qrc"]] placeholderImage:nil];
            weakSelf.codeLabel.text = network_model.data[@"url"];
//            self.jiangliLabel.text = model.data[@"memo"];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
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
