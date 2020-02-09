//
//  HeBi_ApplyShop_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/24.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_ApplyShop_AlertView.h"

@interface HeBi_ApplyShop_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *boxButton;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@end
@implementation HeBi_ApplyShop_AlertView

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        self.titleArray = @[
                            SSKJLocalized(@"步骤一：提交申请", nil),
                            SSKJLocalized(@"步骤二：资料审核", nil),
                            ];
        self.contentArray = @[
                              [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"买卖商户必须为平台认证商户，并在本页面点击“确认申请”按钮，提交申请，并同意冻结", nil),[SSKJ_User_Tool sharedUserTool].userInfoModel.AB,SSKJLocalized(@"AB作为商家保证金。", nil)],
                            SSKJLocalized(@"我们平台会在72小时内进行审核商家申请资料及匹配以往交易，确认符合商家申请条件，您可以在法币交易区发布广告。如申请条件未符合，我们将12小时内联系您，请保持通讯畅通", nil)
                            ];
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.subTitleLabel];
        [self addContents];
        [self.showView addSubview:self.boxButton];
        [self.showView addSubview:self.warningLabel];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.cancleButton.bottom + ScaleW(20);
        self.showView.centerY = ScreenHeight / 2;
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(32), 0, self.width - ScaleW(64), ScaleW(190))];
        _showView.backgroundColor = kSubBackgroundColor;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"商家申请", nil) font:systemFont(ScaleW(16)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(ScaleW(15), ScaleW(37), self.showView.width - ScaleW(30), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (nil == _subTitleLabel) {
        _subTitleLabel = [WLTools allocLabel:SSKJLocalized(@"如何申请成为商家", nil) font:systemFont(ScaleW(15)) textColor:[UIColor colorWithHexStringToColor:@"b2b9e7"] frame:CGRectMake(ScaleW(24), self.titleLabel.bottom + ScaleW(29), self.showView.width - ScaleW(48), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _subTitleLabel;
}

-(void)addContents
{
    CGFloat startY = self.subTitleLabel.bottom + ScaleW(31);
    
    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = self.titleArray[i];
        NSString *content = self.contentArray[i];
        
        UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kTextLightBlueColor frame:CGRectMake(ScaleW(24), startY, self.showView.width - ScaleW(48), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        [self.showView addSubview:titleLabel];
        
        CGFloat height = [content boundingRectWithSize:CGSizeMake(titleLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(13))} context:nil].size.height;
        UILabel *contentLabel = [WLTools allocLabel:content font:systemFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"8d93bc"] frame:CGRectMake(ScaleW(24), titleLabel.bottom + ScaleW(21), titleLabel.width, height) textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        [self.showView addSubview:contentLabel];
        startY = contentLabel.bottom + ScaleW(26);
        if (i == self.titleArray.count - 1) {
            startY -= ScaleW(13);
            
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.x, startY, titleLabel.width, 0.5)];
            self.lineView.backgroundColor = kMainBackgroundColor;
            [self.showView addSubview:self.lineView];
        }
        
    }
}

-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(self.lineView.x - ScaleW(10), self.lineView.bottom + ScaleW(3), ScaleW(30), ScaleW(20))];
        [_boxButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"all_selected"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(boxEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxButton;
}

-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        NSString *s = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"同意冻结", nil),[SSKJ_User_Tool sharedUserTool].userInfoModel.AB,SSKJLocalized(@"AB作为商家保证金。", nil)];
        _warningLabel = [WLTools allocLabel:s font:systemFont(ScaleW(11)) textColor:kTextLightBlueColor frame:CGRectMake(self.boxButton.right, 0, self.showView.width - self.boxButton.right, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _warningLabel.centerY = self.boxButton.centerY;
    }
    return _warningLabel;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(37), self.warningLabel.bottom + ScaleW(20), ScaleW(105), ScaleW(35))];
        _cancleButton.layer.masksToBounds = YES;
//        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
//        _cancleButton.layer.borderColor = kTextLightBlueColor.CGColor;
//        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.width - ScaleW(37) - ScaleW(105), self.cancleButton.y, ScaleW(105), ScaleW(35))];
//        _confirmButton.backgroundColor = kTextLightBlueColor;
//        _confirmButton.layer.cornerRadius = _confirmButton.height / 2;
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    
    
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    
    if (!self.boxButton.selected) {
        NSString *s = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"同意冻结", nil),[SSKJ_User_Tool sharedUserTool].userInfoModel.AB,SSKJLocalized(@"AB作为商家保证金。", nil)];
        [MBProgressHUD showError:s];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

-(void)boxEvent
{
    self.boxButton.selected = !self.boxButton.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
