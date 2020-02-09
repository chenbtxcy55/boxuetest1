//
//  Shop_PuplishSucess_View.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_PuplishSucess_View.h"
@interface Shop_PuplishSucess_View()
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *sucessImg;

@property (nonatomic, strong) UILabel *publishMessage;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *IKnowBtn;


@end


@implementation Shop_PuplishSucess_View

-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.backgroundColor = kClearBackColor;
        
        [self addSubview:self.mainView];
        
        
        [self.mainView addSubview:self.sucessImg];
        
        [self.mainView addSubview:self.titleLabel];

//        [self.mainView addSubview:self.publishMessage];
        
        [self.mainView addSubview:self.lineView];
        
        [self.mainView addSubview:self.IKnowBtn];
        
        self.mainView.centerY = ScreenHeight/2.f;
    }
    return self;
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(195))];
        _mainView.backgroundColor = kBgColor353750;
        
        [_mainView setCornerRadius:ScaleW(10)];
        
        
    }
    return _mainView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"发布成功" font:systemFont(ScaleW(16)) textColor:kMainTextColor frame:CGRectMake(0, self.sucessImg.bottom+ScaleW(20), _mainView.width, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UIImageView *)sucessImg
{
    if (!_sucessImg) {
        _sucessImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(150), ScaleW(44), ScaleW(48), ScaleW(48))];
        _sucessImg.image = [UIImage imageNamed:@"finish"];
        
    }
    return _sucessImg;
}

-(UILabel *)publishMessage
{
    if (!_publishMessage) {
        _publishMessage = [WLTools allocLabel:@"发布成功，审核通过后方可上架" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(0, _sucessImg.bottom + ScaleW(15), _mainView.width, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _publishMessage;
}
-(UIView *)lineView
{
    if (!_lineView ) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom + ScaleW(21), _mainView.width, ScaleW(1))];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}

-(UIButton *)IKnowBtn
{
    if (!_IKnowBtn) {
        _IKnowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _IKnowBtn.frame = CGRectMake(0, _lineView.bottom, _mainView.width, ScaleW(50));
        [_IKnowBtn btn:_IKnowBtn font:ScaleW(15) textColor:kMainRedColor text:@"我知道了" image:nil sel:@selector(IKnowBtnAction:) taget:self];
        
    }
    return _IKnowBtn;
}
-(void)IKnowBtnAction:(UIButton *)sender
{
    !self.ensureBlock?:self.ensureBlock();
}
@end
