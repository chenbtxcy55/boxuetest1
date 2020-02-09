//
//  HeBi_Charge_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Charge_HeaderView.h"

@interface HeBi_Charge_HeaderView ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UILabel *longPressLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *dumplicationButton; // 复制按钮

@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation HeBi_Charge_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.qrCodeImageView];
    [self.backView addSubview:self.longPressLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.addressLabel];
    [self.backView addSubview:self.dumplicationButton];
    self.backView.height = self.dumplicationButton.bottom + ScaleW(42);
    [self addSubview:self.tipLabel];
    self.height = self.tipLabel.bottom + ScaleW(35);
}

-(UIImageView *)backView
{
    if (nil == _backView) {
        _backView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(49), ScaleW(50), ScreenWidth - ScaleW(98), ScaleW(305))];
        _backView.backgroundColor = kSubBackgroundColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(8);
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(38), ScaleW(114), ScaleW(114))];
        _qrCodeImageView.centerX = self.backView.width / 2;
        _qrCodeImageView.layer.borderColor = kMainWihteColor.CGColor;
        _qrCodeImageView.layer.borderWidth = ScaleW(4);
        _qrCodeImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveQRCode:)];
        [_qrCodeImageView addGestureRecognizer:gesture];
    }
    return _qrCodeImageView;
}

-(UILabel *)longPressLabel
{
    if (nil == _longPressLabel) {
        _longPressLabel = [WLTools allocLabel:SSKJLocalized(@"长按保存二维码", nil) font:systemFont(ScaleW(13)) textColor: kMainTextColor frame:CGRectMake(0, self.qrCodeImageView.bottom + ScaleW(18), self.backView.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _longPressLabel;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), self.longPressLabel.bottom + ScaleW(23), self.backView.width - ScaleW(22), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}

-(UILabel *)addressLabel
{
    if (nil == _addressLabel) {
        _addressLabel = [WLTools allocLabel:@"werqwerqerqer" font:systemFont(ScaleW(13.5)) textColor:kTextLightBlueColor frame:CGRectMake(ScaleW(15), self.lineView.bottom + ScaleW(25), self.backView.width - ScaleW(30), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _addressLabel;
}

-(UIButton *)dumplicationButton
{
    if (nil == _dumplicationButton) {
        
        _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.addressLabel.bottom + ScaleW(21), ScaleW(140), ScaleW(40))];
        _dumplicationButton.centerX = self.lineView.centerX;
        [_dumplicationButton addGradientColor];
        [_dumplicationButton setTitle:SSKJLocalized(@"复制钱包地址", nil) forState:UIControlStateNormal];
        [_dumplicationButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _dumplicationButton.titleLabel.font = systemFont(ScaleW(15));
        _dumplicationButton.layer.cornerRadius = 6.0f;
        [_dumplicationButton addTarget:self action:@selector(dumplicationEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dumplicationButton;
}

-(UILabel *)tipLabel
{
    if (nil == _tipLabel) {
        
        NSString *text = @"";
        
        _tipLabel = [WLTools allocLabel:text font:systemThinFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(self.backView.x, self.backView.bottom + ScaleW(28), self.width - 2 * self.backView.x, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _tipLabel.numberOfLines = 0;
        CGFloat height = [text boundingRectWithSize:CGSizeMake(_tipLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_tipLabel.font} context:nil].size.height;
        _tipLabel.height = height;
        
    }
    return _tipLabel;
}

#pragma mark - 用户操作
-(void)dumplicationEvent
{
    if (self.addressLabel.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"地址获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.addressLabel.text;
}

-(void)setViewWithModel:(HeBi_Charge_Model *)model
{
//    self.tipLabel.text = [NSString stringWithFormat:@"提示：最小充币%@AB(小于无法入账)",model.cz_fee_min];
    [self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.qrc]]];
    self.addressLabel.text = model.url;
}


-(void)saveQRCode:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan && self.qrCodeImageView.image) {
        UIImageWriteToSavedPhotosAlbum(self.qrCodeImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);

    }
}


// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil) ];
    } else {
        [MBProgressHUD showSuccess:SSKJLocalized(@"保存成功",nil)];
    }
}


-(void)setViewWithCoinName:(NSString *)coinName
{
    self.tipLabel.text = [NSString stringWithFormat:SSKJLocalized(@"请勿向上述地址充值任何非%@资产，否则资产将不可找回。\n您充值至上述地址后，需要整个网络节点的确认，6次网络确认后到账。\n您可以在充值记录里查看充值状态！", nil),coinName];
    
    CGFloat height = [self.tipLabel.text boundingRectWithSize:CGSizeMake(self.tipLabel.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.tipLabel.font} context:nil].size.height;
    self.tipLabel.height = height;
    self.height = self.tipLabel.bottom + ScaleW(10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
