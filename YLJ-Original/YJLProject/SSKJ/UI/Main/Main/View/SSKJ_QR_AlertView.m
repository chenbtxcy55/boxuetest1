//
//  SSKJ_QR_AlertView.m
//  SSKJ
//
//  Created by cy5566 on 2019/12/2.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_QR_AlertView.h"
@interface SSKJ_QR_AlertView ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *myAlertView;
//
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *QRImgView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleEnLabel;
@property (nonatomic, strong) UIScrollView *contentScroll;

@property (nonatomic, strong) UILabel *contengLabel;    // 更新内容
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancleBlock)(void);

@end
@implementation SSKJ_QR_AlertView

+(void)showWithUrl:(NSString *)urlstr confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock {
    SSKJ_QR_AlertView *versionAlertView = [[SSKJ_QR_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    versionAlertView.confirmBlock = confirmblock;
    versionAlertView.cancleBlock = cancleBlock;
//    versionAlertView.contengLabel.text = content;
//    [versionAlertView.QRImgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    versionAlertView.QRImgView.image = [UIImage imageNamed:urlstr];
//    CGFloat height = [content boundingRectWithSize:CGSizeMake(versionAlertView.contengLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(13.5))} context:nil].size.height;
    
//    versionAlertView.contengLabel.height = height;
    //    versionAlertView.confirmButton.y = versionAlertView.contengLabel.bottom + ScaleW(32);
    
//    if (height>versionAlertView.contentScroll.height) {
//
//        versionAlertView.contentScroll.contentSize = CGSizeMake(versionAlertView.contentScroll.width, height+ScaleW(10));
//
//    }
//    else
//    {
//        versionAlertView.contentScroll.height = height+ScaleW(10);
//
//
//    }
    
//    versionAlertView.myAlertView.height = versionAlertView.contentScroll.bottom + ScaleW(52) +ScaleW(45) + ScaleW(30);
        versionAlertView.myAlertView.height = ScaleW(308);
    
    versionAlertView.myAlertView.centerY = ScreenHeight / 2;
//    versionAlertView.confirmButton.bottom = versionAlertView.myAlertView.height - ScaleW(23);
    UIImage * image = [UIImage imageNamed:@"bounce_bg"];
    
    CGFloat top = ScaleW(120);
    CGFloat left = 0;
    CGFloat bottom = ScaleW(60);
    CGFloat right = 0;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    
    //    versionAlertView.alertView.image = newImage;
    
    versionAlertView.cancleButton.hidden = YES;
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:versionAlertView];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.myAlertView];
//    [self.alertView addSubview:self.imageView];
    //    [self.imageView addSubview:self.titleLabel];
    //    [self.imageView addSubview:self.titleEnLabel];
//    [self.myAlertView addSubview:self.contentScroll];
    [self.myAlertView addSubview:self.QRImgView];
//    [self.contentScroll addSubview:self.contengLabel];
    [self.myAlertView addSubview:self.confirmButton];
    [self addSubview:self.cancleButton];
}

-(UIImageView *)myAlertView
{
    if (nil == _myAlertView) {
        _myAlertView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(23), 0, ScaleW(330), 0)];
        _myAlertView.userInteractionEnabled = YES;
        
        //        _alertView.image = [UIImage imageNamed:@"bounce_bg"];
        _myAlertView.centerX = ScreenWidth / 2;
        _myAlertView.backgroundColor = kMainColor;
        //        _alertView.layer.cornerRadius = ScaleW(8);
        [_myAlertView setCornerRadius:ScaleW(10)];
    }
    return _myAlertView;
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.myAlertView.width, ScaleW(124))];
        _imageView.image = [UIImage imageNamed:@"wd-bg-img-server"];
        //        UILabel *label = [WLTools allocLabel:@"系统公告" font:systemBoldFont(ScaleW(18)) textColor:kMainColor frame:CGRectMake(ScaleW(31), ScaleW(40), ScaleW(150), ScaleW(18)) textAlignment:NSTextAlignmentLeft];
        //        [_imageView addSubview:label];
    }
    return _imageView;
}

- (UIImageView *)QRImgView {
    if (nil == _QRImgView) {
        _QRImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(90), ScaleW(60), ScaleW(150), ScaleW(150))];
    }
    return _QRImgView;
}

-(UIScrollView *)contentScroll
{
    if (nil == _contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(ScaleW(25), self.imageView.bottom + ScaleW(14), self.myAlertView.width - ScaleW(50), ScaleW(150))];
        
        _contentScroll.pagingEnabled = YES;
        _contentScroll.showsVerticalScrollIndicator = NO;
        
        //        _contentScroll.contentSize = CGSizeMake(ScreenWidth * 2, _scrollView.height);
        
        _contentScroll.delegate = self;
        _contentScroll.backgroundColor = [UIColor clearColor];
    }
    
    return _contentScroll;
    
}
-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"系统公告",nil) font:systemFont(ScaleW(21)) textColor:kMainTextColor frame:CGRectMake(ScaleW(0), ScaleW(125), self.myAlertView.width, ScaleW(16)) textAlignment:NSTextAlignmentCenter];
        //        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UILabel *)titleEnLabel
{
    if (nil == _titleEnLabel) {
        _titleEnLabel = [WLTools allocLabel:SSKJLocalized(@"Latest Announcement",nil) font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(25), _titleLabel.bottom + ScaleW(5), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
        [_titleEnLabel sizeToFit];
    }
    return _titleEnLabel;
}

-(UILabel *)contengLabel
{
    if (nil == _contengLabel) {
        _contengLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(0), 0, self.myAlertView.width - ScaleW(50), 0) textAlignment:NSTextAlignmentLeft];
        
    }
    return _contengLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
//        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contengLabel.bottom + ScaleW(32), ScaleW(300), ScaleW(45))];
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.QRImgView.bottom + ScaleW(32), ScaleW(300), ScaleW(45))];

        _confirmButton.centerX = self.myAlertView.width / 2;
        _confirmButton.backgroundColor = kTheMeColor;
        //        [_confirmButton setTitle:SSKJLocalized(@"联系客服", nil) forState:UIControlStateNormal];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton setCornerRadius:ScaleW(5)];
        //        _confirmButton.layer.borderWidth = ScaleW(1);
        //        _confirmButton.layer.borderColor =kGreenColor.CGColor;
        
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(40))];
        [_cancleButton setImage:[UIImage imageNamed:@"cancleOne_FBC"] forState:UIControlStateNormal];
        _cancleButton.centerX = self.myAlertView.centerX;
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self hide];
}




-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self hide];
}

-(void)hide
{
    [self removeFromSuperview];
}

@end
