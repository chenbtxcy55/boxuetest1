//
//  HomepageHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HomepageHeaderView.h"
#import "SDCycleScrollView.h"
#import "XBTextLoopView.h"
#import "HomepageCollectionViewCell.h"
#import "NewPagedFlowView.h"
#import "BannerPageControl.h"
#import "LA_Main_BlockVew.h"

@interface HomepageHeaderView()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
//@property (nonatomic, strong) SDCycleScrollView *headerView;

@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

@property (nonatomic, strong) UIView *notifacationView;
@property (nonatomic, strong) UIImageView *notifaImg;
@property (nonatomic, strong) XBTextLoopView *rodlodText;
@property (nonatomic, strong) UIView *signBackView;

@property (nonatomic, strong) LA_Main_BlockVew *shopView;
@property (nonatomic, strong) LA_Main_BlockVew *inviteFrirndView;



@property (nonatomic, strong) SSKJ_Market_Index_Model *btcModel;
@property (nonatomic, strong) SSKJ_Market_Index_Model *ethModel;
@property (nonatomic, strong) SSKJ_Market_Index_Model *omgModel;

@property (nonatomic,strong) UIButton *gongsiBtn;
@property (nonatomic,strong) UIButton *chanpinBtn;

@end
@implementation HomepageHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(372));
    self.backgroundColor = kGrayWhiteColor;

    [self addSubview:self.pageFlowView];
    [self addSubview:self.notifacationView];
    
    UIButton * moreBtn =[WLTools allocButton:[NSString stringWithFormat:@"%@ ",SSKJLocalized(@"", nil)] textColor:kMainTextColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.notifacationView.width -ScaleW(40), 0, ScaleW(40),  self.notifacationView.height)];
    [moreBtn setImage:SSKJIMAGE_NAMED(@"wd_icon_right") forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(lookMore) forControlEvents:UIControlEventTouchUpInside];
    
//    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - moreBtn.imageView.image.size.width, 0, moreBtn.imageView.image.size.width)];
//    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, moreBtn.titleLabel.bounds.size.width, 0, -moreBtn.titleLabel.bounds.size.width)];
////    moreBtn.backgroundColor =[UIColor redColor];
//    moreBtn.titleLabel.font = systemScaleFont(13);
    
    [self.notifacationView addSubview:moreBtn];
    
    [self addSubview:self.signBackView];
//    [self addSubview:self.shopView];
//    [self addSubview:self.inviteFrirndView];
    [self addSubview:self.gongsiBtn];
    [self addSubview:self.chanpinBtn];
    
    
    self.height = self.gongsiBtn.bottom +ScaleW(10) ;
    
}


-(void)lookMore
{
    if (self.lookMoreBlock) {
        self.lookMoreBlock();
    }
    
}

- (NewPagedFlowView *)pageFlowView{
    if (_pageFlowView == nil) {
        UIImage *imageHeight=[UIImage imageNamed:@"banner_default"];
        _pageFlowView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(ScaleW(15),ScaleW(11), ScreenWidth-ScaleW(15)*2, imageHeight.size.height)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        
        _pageFlowView.layer.cornerRadius = 4;
        _pageFlowView.layer.masksToBounds = YES;
        //初始化pageControl
        BannerPageControl *pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - ScaleW(10), ScreenWidth- ScaleW(30), 8)];
        pageControl.pageIndicatorTintColor = [UIColor clearColor];
        pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
        _pageFlowView.pageControl = pageControl;
        [_pageFlowView addSubview:pageControl];
        [_pageFlowView reloadData];
        
        [self addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

- (UIView *)signBackView {
    if (nil == _signBackView) {
        _signBackView = [UIView new];
        _signBackView.backgroundColor = kMainWihteColor;
        _signBackView.frame = CGRectMake(ScaleW(15), self.notifacationView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(90));
        UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(60), ScaleW(60)) imageName:@"homepage_sign"];
//        imgView.backgroundColor = [UIColor redColor];
        UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(imgView.right + ScaleW(20), ScaleW(25), ScaleW(180), ScaleW(16)) text:SSKJLocalized(@"您还有一份惊喜未领取", nil) textColor:kTheMeColor font:systemFont(ScaleW(16))];
        UILabel *subLabel = [FactoryUI createLabelWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(130), ScaleW(14)) text:SSKJLocalized(@"每日签到，惊喜多多", nil) textColor:kGrayTitleColor font:systemFont(ScaleW(14))];
        UIButton *signBtn = [FactoryUI createButtonWithFrame:CGRectMake(_signBackView.width - ScaleW(60) - ScaleW(10), ScaleW(34), ScaleW(60), ScaleW(22)) title:SSKJLocalized(@"立即签到", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(signEvent) font:systemFont(ScaleW(12))];
        signBtn.backgroundColor = kTheMeColor;
        [signBtn setCornerRadius:ScaleW(11)];
        
        [_signBackView addSubview:imgView];
        [_signBackView addSubview:titleLabel];
        [_signBackView addSubview:subLabel];
        [_signBackView addSubview:signBtn];

    }
    return _signBackView;
}

-(UIView *)notifacationView
{
    if (!_notifacationView) {
        _notifacationView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10) + self.pageFlowView.bottom,ScreenWidth -ScaleW(30), ScaleW(38))];
//        [_notifacationView setCornerRadius:_notifacationView.height / 2];
        _notifacationView.backgroundColor = kMainWihteColor;
        
//        _notifacationView.layer.cornerRadius = _notifacationView.height/2;
//
//        _notifacationView.layer.masksToBounds = YES;
        
        _notifaImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"homepage_tz"]];
        _notifaImg.frame = CGRectMake(ScaleW(15), 0, ScaleW(16), ScaleW(18));
        _notifaImg.centerY = _notifacationView.height/2;
//        _notifaImg.left = ScaleW(15);
//        _notifacationView.backgroundColor = kTextColor282c4f;
        [_notifacationView addSubview:_notifaImg];
        _notifaImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showNewsList)];
        [_notifaImg addGestureRecognizer:tap];
        
      
        
        

    }
    return _notifacationView;
}



-(LA_Main_BlockVew *)shopView
{
    if (nil == _shopView) {
        _shopView = [[LA_Main_BlockVew alloc]initWithFrame:CGRectMake(ScaleW(15), self.signBackView.bottom+ScaleW(10), (ScreenWidth - ScaleW(30) - ScaleW(8))/2, ScaleW(80)) title:SSKJLocalized(@"产品介绍", nil) subTitle:SSKJLocalized(@"你想知道的都在这里", nil) imageName:SSKJLocalized(@"sy_img_1", nil)];
        [_shopView setCornerRadius:ScaleW(3)];
//        _shopView.backgroundColor = kBgColor353750;
        
        
//        UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(_shopView.titleLabel.left, _shopView.titleLabel.bottom +ScaleW(10), ScaleW(26), ScaleW(2))];
//        lineImageView.backgroundColor = UIColorFromRGB(0x97c354);
//        [_shopView addSubview:lineImageView];
        
        
        WS(weakSelf);
        _shopView.clickBlock = ^{
            if (weakSelf.shopBlock) {
                weakSelf.shopBlock();
            }
        };
        
    }
    return _shopView;
}

- (UIButton *)gongsiBtn {
    if (!_gongsiBtn) {
        _gongsiBtn = [WLTools allocButton:@"公司介绍" textColor:kMainColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), self.signBackView.bottom+ScaleW(10), (ScreenWidth - ScaleW(30))/2, ScaleW(34))];
        _gongsiBtn.titleLabel.font = systemFont(ScaleW(14));
        _gongsiBtn.backgroundColor = kTheMeColor;
        [_gongsiBtn addTarget:self action:@selector(gongsiEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gongsiBtn;
}

- (UIButton *)chanpinBtn {
    if (!_chanpinBtn) {
        _chanpinBtn = [WLTools allocButton:@"产品介绍" textColor:kMainColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15) + ((ScreenWidth - ScaleW(30))/2), self.signBackView.bottom+ScaleW(10), (ScreenWidth - ScaleW(30))/2, ScaleW(34))];
        _chanpinBtn.titleLabel.font = systemFont(ScaleW(14));
        _chanpinBtn.backgroundColor = UIColorFromRGB(0xf0f0f0);
        [_chanpinBtn setTitleColor:kMainTextColor forState:UIControlStateNormal];
        [_chanpinBtn addTarget:self action:@selector(chanpinEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chanpinBtn;
}
- (void)chanpinEvent {
//    if (self.shopBlock) {
//        self.shopBlock();
//    }
    if (self.inviteBlock) {
        self.inviteBlock();
    }
    self.chanpinBtn.backgroundColor = kTheMeColor;
    [self.chanpinBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    self.gongsiBtn.backgroundColor = UIColorFromRGB(0xf0f0f0);
    [self.gongsiBtn setTitleColor:kMainTextColor forState:UIControlStateNormal];
}
- (void)gongsiEvent {
//    if (self.inviteBlock) {
//        self.inviteBlock();
//    }
    if (self.shopBlock) {
        self.shopBlock();
    }
    
    self.chanpinBtn.backgroundColor = UIColorFromRGB(0xf0f0f0);
    [self.chanpinBtn setTitleColor:kMainTextColor forState:UIControlStateNormal];
    self.gongsiBtn.backgroundColor = kTheMeColor;
    [self.gongsiBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
    
}

-(LA_Main_BlockVew *)inviteFrirndView
{
    if (nil == _inviteFrirndView) {
        _inviteFrirndView = [[LA_Main_BlockVew alloc]initWithFrame:CGRectMake(ScaleW(10)+self.shopView.right, self.signBackView.bottom+ScaleW(10), (ScreenWidth - ScaleW(30) - ScaleW(8))/2, ScaleW(80)) title:SSKJLocalized(@"公司介绍", nil) subTitle:SSKJLocalized(@"点击一下了解更多", nil) imageName:SSKJLocalized(@"sy_img_2", nil)];
        [_inviteFrirndView setCornerRadius:ScaleW(3)];
//        _inviteFrirndView.backgroundColor = kBgColor353750;
        
//        UILabel * titleLabel = [WLTools allocLabel:SSKJLocalized(@"赚佣金", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(11), _inviteFrirndView.titleLabel.bottom + ScaleW(5), ScaleW(120), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
//        titleLabel.numberOfLines = 0;
//        [_inviteFrirndView addSubview:titleLabel];
        //        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
        WS(weakSelf);
        _inviteFrirndView.clickBlock = ^{
            if (weakSelf.inviteBlock) {
                weakSelf.inviteBlock();
            }
        };
        
    }
    return _inviteFrirndView;
}

- (void)signEvent {
    if (self.signBlock) {
        self.signBlock();
    }
}

-(void)helpCenterEvent
{
    
    if (self.HelpCenterBlock) {
        self.HelpCenterBlock();
    }
    
}

-(void)showNewsList
{
    if (self.newListBlock) {
        self.newListBlock();
    }

}

-(void)setNoticeArray:(NSArray *)noticeArray
{
    _noticeArray = noticeArray;
    [_rodlodText removeFromSuperview];
    WS(weakSelf);
    _rodlodText = [XBTextLoopView textLoopViewWith:_noticeArray loopInterval:5.f initWithFrame:CGRectMake(ScaleW(11) + _notifaImg.right, 0, ScaleW(270), self.notifacationView.height) selectBlock:^(NSString *selectString, NSInteger index) {
        if (weakSelf.newsIndexBlock) {
            weakSelf.newsIndexBlock(index);
        }
    }];
    [_notifacationView addSubview:_rodlodText];
}



-(void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    [self.pageFlowView reloadData];
    
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    UIImage *imageHeight=[UIImage imageNamed:@"banner_default"];
    return CGSizeMake(ScreenWidth - ScaleW(30), imageHeight.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    if (self.bannerArray.count>0)
    {
        if (self.bannerClickBlock)
        {
            self.bannerClickBlock(subIndex);
        }
    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.bannerArray.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    NSDictionary * dic = self.bannerArray[index];
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:dic[@"banner_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default"]];
    
    return bannerView;
}




@end
