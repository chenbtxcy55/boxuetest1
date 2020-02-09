//
//  SSKJ_Version_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_Version_AlertView.h"

@interface SSKJ_Version_AlertView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *alertView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *contentScroll;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contengLabel;    // 更新内容

@property (nonatomic, strong)UILabel *topTitleLabel;

@property (nonatomic, strong)UILabel *topVersionLabel;

@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancleBlock)(void);

@end

@implementation SSKJ_Version_AlertView

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
    [self addSubview:self.alertView];
//    [self.alertView addSubview:self.imageView];
//
//    [self.imageView addSubview:self.topTitleLabel];
//    [self.imageView addSubview:self.topVersionLabel];

//    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.contentScroll];

    [self.contentScroll addSubview:self.contengLabel];

    [self.alertView addSubview:self.cancleButton];

    [self.alertView addSubview:self.confirmButton];
}

-(UIImageView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(35), 0, ScaleW(209), 0)];
        _alertView.userInteractionEnabled = YES;
//        _alertView.centerX = ScreenWidth / 2;
//        _alertView.layer.cornerRadius = ScaleW(8);
    }
    return _alertView;
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.width, ScaleW(141))];
        _imageView.image = [UIImage imageNamed:SSKJLocalized(@"bbgx_img1", nil)];
    }
    return _imageView;
}


-(UILabel *)topTitleLabel
{
    if (nil == _topTitleLabel) {
        _topTitleLabel = [WLTools allocLabel:SSKJLocalized(@"版本更新啦！",nil) font:systemFont(ScaleW(21)) textColor:kMainTextColor frame:CGRectMake(ScaleW(25), ScaleW(45), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
        [_topTitleLabel sizeToFit];
    }
    return _topTitleLabel;
}
-(UIScrollView *)contentScroll
{
    if (nil == _contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(ScaleW(25),  ScaleW(236), self.alertView.width - ScaleW(50), ScaleW(150))];
        
        _contentScroll.pagingEnabled = YES;
        _contentScroll.showsVerticalScrollIndicator = NO;

//        _contentScroll.contentSize = CGSizeMake(ScreenWidth * 2, _scrollView.height);
        
        _contentScroll.delegate = self;
        _contentScroll.backgroundColor = [UIColor clearColor];
    }
    
    return _contentScroll;
    
}
-(UILabel *)topVersionLabel
{
    if (nil == _topVersionLabel) {
        _topVersionLabel = [WLTools allocLabel:[NSString stringWithFormat:@"V %@",AppVersion] font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(25), _topTitleLabel.bottom + ScaleW(5), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
        [_topVersionLabel sizeToFit];
    }
    return _topVersionLabel;
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"更新内容",nil) font:systemFont(ScaleW(21)) textColor:kMainTextColor frame:CGRectMake(ScaleW(25), ScaleW(148), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)contengLabel
{
    if (nil == _contengLabel) {
        _contengLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(0),  ScaleW(0), self.alertView.width - ScaleW(50), 0) textAlignment:NSTextAlignmentLeft];
    }
    return _contengLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right + ScaleW(15), self.contengLabel.bottom + ScaleW(14), ScaleW(80), ScaleW(30))];
        _confirmButton.backgroundColor = kGreenColor;
        [_confirmButton setTitle:SSKJLocalized(@"立即更新", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainTextColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = ScaleW(5);
        
        _confirmButton.layer.masksToBounds = YES;
        
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(21),  self.contengLabel.bottom + ScaleW(14), ScaleW(80), ScaleW(30))];
//        [_cancleButton setImage:[UIImage imageNamed:@"cancleOne_FBC"] forState:UIControlStateNormal];
        
        _cancleButton.backgroundColor = [UIColor clearColor];
        [_cancleButton setTitle:SSKJLocalized(@"稍后更新", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor: UIColorFromRGB(0xc4c4c4) forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _cancleButton.layer.cornerRadius = ScaleW(5);
        _cancleButton.layer.masksToBounds = YES;

        _cancleButton.layer.borderColor = UIColorFromRGB(0xc4c4c4).CGColor;
        _cancleButton.layer.borderWidth = ScaleW(1);

        
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
   
//    [self hide];
}


+(void)showWithModel:(SSKJ_Version_Model *)model confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock
{
    
 
    SSKJ_Version_AlertView *versionAlertView = [[SSKJ_Version_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    versionAlertView.confirmBlock = confirmblock;
    versionAlertView.cancleBlock = cancleBlock;
//    versionAlertView.titleLabel.text = model.title;
//    versionAlertView.titleLabel.height = 0;
    
    versionAlertView.contengLabel.text = model.content;
    CGFloat height = [model.content boundingRectWithSize:CGSizeMake(versionAlertView.contengLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(13.5))} context:nil].size.height;
    versionAlertView.contengLabel.height = height;
    if (height>versionAlertView.contentScroll.height) {
        
        versionAlertView.contentScroll.contentSize = CGSizeMake(versionAlertView.contentScroll.width, height);
        
    }
    else
    {
        versionAlertView.contentScroll.height = height+ScaleW(10);

        
    }
    
    versionAlertView.cancleButton.y = versionAlertView.contentScroll.bottom + ScaleW(16);

    versionAlertView.confirmButton.y = versionAlertView.contentScroll.bottom + ScaleW(16);

    versionAlertView.alertView.height = versionAlertView.confirmButton.bottom + ScaleW(17);
    versionAlertView.alertView.centerY = ScreenHeight / 2;
    versionAlertView.alertView.centerX = ScreenWidth / 2;

    if (model.uptype.integerValue == 1) {
        versionAlertView.cancleButton.hidden = YES;
        
        
        versionAlertView.confirmButton.left = ScaleW(21);
        
        versionAlertView.confirmButton.width = versionAlertView.alertView.width- ScaleW(21)*2;

    }
    
    
    
    UIImage * image = [UIImage imageNamed:@"version_bg"];
    
    CGFloat top = ScaleW(236);
    CGFloat left = 0;
    CGFloat bottom = ScaleW(0);
    CGFloat right = 0;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    
    versionAlertView.alertView.image = newImage;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:versionAlertView];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
